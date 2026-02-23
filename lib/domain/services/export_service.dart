import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/saved_schedule.dart';
import '../models/schedule_table.dart';

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
    final classes = table.getAllClasses();

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
                return slot.when(
                  classSlot: (classData, rowspan, colspan, duration) {
                    final room = classData.rooms.isNotEmpty
                        ? classData.rooms.first
                        : '';
                    return _pdfCell(
                      '${classData.code}\n$room',
                      bgColor: PdfColors.blue100,
                    );
                  },
                  barSlot: (label, rowspan, colspan) {
                    return _pdfCell(label, bgColor: PdfColors.orange100);
                  },
                  emptySlot: (rowspan, colspan) {
                    return _pdfCell('');
                  },
                );
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
}
