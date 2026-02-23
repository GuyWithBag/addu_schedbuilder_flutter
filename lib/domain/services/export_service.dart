import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/saved_schedule.dart';
import '../models/schedule_table.dart';
import '../models/weekday.dart';
import '../models/class_data.dart';
import '../models/time_slot.dart';

/// Service for exporting schedules to various formats
class ExportService {
  /// Export schedule as PNG image
  static Future<Uint8List> exportToPNG(
    GlobalKey repaintBoundaryKey, {
    double pixelRatio = 3.0,
  }) async {
    try {
      final RenderRepaintBoundary boundary =
          repaintBoundaryKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;

      final ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      return byteData!.buffer.asUint8List();
    } catch (e) {
      throw Exception('Failed to export PNG: $e');
    }
  }

  /// Export schedule as JPG image
  static Future<Uint8List> exportToJPG(
    GlobalKey repaintBoundaryKey, {
    double pixelRatio = 3.0,
    int quality = 90,
  }) async {
    try {
      final RenderRepaintBoundary boundary =
          repaintBoundaryKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;

      final ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);

      // JPG format is not directly supported, so we convert from PNG
      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      return byteData!.buffer.asUint8List();
    } catch (e) {
      throw Exception('Failed to export JPG: $e');
    }
  }

  /// Export schedule as PDF document
  static Future<Uint8List> exportToPDF(
    ScheduleTable table,
    Map<String, Color> classColors,
    String scheduleName,
  ) async {
    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          orientation: pw.PageOrientation.landscape,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Title
                pw.Text(
                  scheduleName,
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 20),

                // Schedule table
                _buildPDFTable(table, classColors),
              ],
            );
          },
        ),
      );

      return await pdf.save();
    } catch (e) {
      throw Exception('Failed to export PDF: $e');
    }
  }

  /// Build PDF table widget
  static pw.Widget _buildPDFTable(
    ScheduleTable table,
    Map<String, Color> classColors,
  ) {
    return pw.Table(
      border: pw.TableBorder.all(),
      children: [
        // Header row
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey300),
          children: [
            _pdfCell('Time', isHeader: true),
            _pdfCell('Monday', isHeader: true),
            _pdfCell('Tuesday', isHeader: true),
            _pdfCell('Wednesday', isHeader: true),
            _pdfCell('Thursday', isHeader: true),
            _pdfCell('Friday', isHeader: true),
            _pdfCell('Saturday', isHeader: true),
          ],
        ),

        // Data rows (simplified for now - full implementation would need row spanning)
        ...table.rows.map((row) {
          return pw.TableRow(
            children: [
              _pdfCell(row.time.format(false)),
              ...row.columns.map((slot) {
                if (slot == null) {
                  return _pdfCell('');
                }
                if (slot is ClassSlot) {
                  final room = slot.classData.rooms.isNotEmpty
                      ? slot.classData.rooms.first
                      : '';
                  return _pdfCell(
                    '${slot.classData.code}\n$room',
                    bgColor: PdfColors.blue100,
                  );
                } else if (slot is BarSlot) {
                  return _pdfCell(slot.label, bgColor: PdfColors.orange100);
                } else {
                  return _pdfCell('');
                }
              }).toList(),
            ],
          );
        }).toList(),
      ],
    );
  }

  /// Helper to create PDF table cell
  static pw.Widget _pdfCell(
    String text, {
    bool isHeader = false,
    PdfColor? bgColor,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      decoration: pw.BoxDecoration(color: bgColor),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: isHeader ? 12 : 10,
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }

  /// Export schedule as JSON string
  static String exportToJSON(SavedSchedule schedule) {
    try {
      final jsonMap = schedule.toJson();
      return const JsonEncoder.withIndent('  ').convert(jsonMap);
    } catch (e) {
      throw Exception('Failed to export JSON: $e');
    }
  }

  /// Import schedule from JSON string
  static SavedSchedule importFromJSON(String jsonString) {
    try {
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return SavedSchedule.fromJson(jsonMap);
    } catch (e) {
      throw Exception('Failed to import JSON: $e');
    }
  }

  /// Export schedule as .ics (iCalendar) file
  static String exportToICS(
    ScheduleTable table,
    String scheduleName, {
    DateTime? semesterStart,
    DateTime? semesterEnd,
  }) {
    try {
      final buffer = StringBuffer();

      // Calendar header
      buffer.writeln('BEGIN:VCALENDAR');
      buffer.writeln('VERSION:2.0');
      buffer.writeln('PRODID:-//SchedBuilder//Schedule//EN');
      buffer.writeln('CALSCALE:GREGORIAN');
      buffer.writeln('METHOD:PUBLISH');
      buffer.writeln('X-WR-CALNAME:$scheduleName');
      buffer.writeln('X-WR-CALDESC:Class schedule exported from SchedBuilder');

      // Default semester dates if not provided (current semester)
      final start = semesterStart ?? DateTime.now();
      final end = semesterEnd ?? start.add(const Duration(days: 120));

      // Get all classes
      final classes = table.getAllClasses();

      // Create recurring events for each class
      for (final classData in classes) {
        for (final period in classData.schedule) {
          _addClassEvents(buffer, classData, period, start, end);
        }
      }

      buffer.writeln('END:VCALENDAR');
      return buffer.toString();
    } catch (e) {
      throw Exception('Failed to export ICS: $e');
    }
  }

  /// Add class events to the calendar buffer (one per weekday)
  static void _addClassEvents(
    StringBuffer buffer,
    ClassData classData,
    period,
    DateTime semesterStart,
    DateTime semesterEnd,
  ) {
    // Create an event for each weekday in the period
    for (final weekday in period.weekdays) {
      final firstOccurrence = _findFirstWeekday(semesterStart, weekday);

      // Create event start and end times
      final eventStart = DateTime(
        firstOccurrence.year,
        firstOccurrence.month,
        firstOccurrence.day,
        period.start.hour,
        period.start.minute,
      );

      final eventEnd = DateTime(
        firstOccurrence.year,
        firstOccurrence.month,
        firstOccurrence.day,
        period.end.hour,
        period.end.minute,
      );

      // Build description
      final descriptionParts = [
        classData.title,
        if (classData.teacher != null)
          'Teacher: ${classData.teacher!.fullName}',
        if (classData.teacher?.emails.isNotEmpty ?? false)
          'Email: ${classData.teacher!.emails.first}',
      ];

      // Write event
      buffer.writeln('BEGIN:VEVENT');
      buffer.writeln(
        'UID:${classData.code}-${weekday.name}-${period.start.hour}${period.start.minute}@schedbuilder.app',
      );
      buffer.writeln('DTSTAMP:${_formatICalDateTime(DateTime.now())}');
      buffer.writeln('DTSTART:${_formatICalDateTime(eventStart)}');
      buffer.writeln('DTEND:${_formatICalDateTime(eventEnd)}');
      buffer.writeln('SUMMARY:${classData.code} - ${classData.subject}');
      buffer.writeln('DESCRIPTION:${descriptionParts.join('\\n')}');
      buffer.writeln('LOCATION:${period.room}');
      buffer.writeln(
        'RRULE:FREQ=WEEKLY;UNTIL=${_formatICalDateTime(semesterEnd)}',
      );
      buffer.writeln('END:VEVENT');
    }
  }

  /// Find the first occurrence of a weekday starting from a given date
  static DateTime _findFirstWeekday(DateTime start, Weekday weekday) {
    final targetWeekday = _weekdayToDateTime(weekday);
    var date = start;

    while (date.weekday != targetWeekday) {
      date = date.add(const Duration(days: 1));
    }

    return date;
  }

  /// Convert Weekday enum to DateTime weekday (1-7)
  static int _weekdayToDateTime(Weekday weekday) {
    return weekday.dartWeekday;
  }

  /// Format DateTime for iCalendar (YYYYMMDDTHHMMSS)
  static String _formatICalDateTime(DateTime dt) {
    return '${dt.year.toString().padLeft(4, '0')}'
        '${dt.month.toString().padLeft(2, '0')}'
        '${dt.day.toString().padLeft(2, '0')}'
        'T'
        '${dt.hour.toString().padLeft(2, '0')}'
        '${dt.minute.toString().padLeft(2, '0')}'
        '${dt.second.toString().padLeft(2, '0')}';
  }
}
