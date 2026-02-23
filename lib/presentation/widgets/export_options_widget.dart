import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../domain/models/saved_schedule.dart';
import '../../domain/services/export_service.dart';

/// Widget showing export options for a schedule
class ExportOptionsWidget extends StatelessWidget {
  final SavedSchedule schedule;
  final GlobalKey? repaintBoundaryKey;
  final Map<String, Color> classColors;

  const ExportOptionsWidget({
    super.key,
    required this.schedule,
    this.repaintBoundaryKey,
    required this.classColors,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        // PNG Export
        FilledButton.tonalIcon(
          onPressed: repaintBoundaryKey != null
              ? () => _exportPNG(context)
              : null,
          icon: const Icon(Icons.image),
          label: const Text('PNG'),
        ),

        // PDF Export
        FilledButton.tonalIcon(
          onPressed: () => _exportPDF(context),
          icon: const Icon(Icons.picture_as_pdf),
          label: const Text('PDF'),
        ),

        // JSON Export
        FilledButton.tonalIcon(
          onPressed: () => _exportJSON(context),
          icon: const Icon(Icons.code),
          label: const Text('JSON'),
        ),

        // Share
        FilledButton.tonalIcon(
          onPressed: () => _shareSchedule(context),
          icon: const Icon(Icons.share),
          label: const Text('Share'),
        ),
      ],
    );
  }

  Future<void> _exportPNG(BuildContext context) async {
    try {
      final bytes = await ExportService.exportToPNG(repaintBoundaryKey!);
      await _saveFile(
        context,
        bytes,
        '${schedule.name}_schedule.png',
        'image/png',
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Schedule exported as PNG!'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error exporting PNG: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _exportPDF(BuildContext context) async {
    try {
      final bytes = await ExportService.exportToPDF(
        schedule.table,
        classColors,
        schedule.name,
      );

      await _saveFile(
        context,
        bytes,
        '${schedule.name}_schedule.pdf',
        'application/pdf',
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Schedule exported as PDF!'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error exporting PDF: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _exportJSON(BuildContext context) async {
    try {
      final jsonString = ExportService.exportToJSON(schedule);
      final bytes = Uint8List.fromList(jsonString.codeUnits);

      await _saveFile(
        context,
        bytes,
        '${schedule.name}_schedule.json',
        'application/json',
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Schedule exported as JSON!'),
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: 'Copy',
              onPressed: () {
                Clipboard.setData(ClipboardData(text: jsonString));
              },
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error exporting JSON: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _shareSchedule(BuildContext context) async {
    try {
      // Share as JSON for now (could be extended to share PDF/PNG)
      final jsonString = ExportService.exportToJSON(schedule);
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/${schedule.name}_schedule.json');
      await file.writeAsString(jsonString);

      await Share.shareXFiles([
        XFile(file.path),
      ], text: 'Check out my schedule: ${schedule.name}');
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sharing: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _saveFile(
    BuildContext context,
    Uint8List bytes,
    String filename,
    String mimeType,
  ) async {
    try {
      // For mobile/web, we'll use share_plus to "save"
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/$filename');
      await file.writeAsBytes(bytes);

      await Share.shareXFiles([
        XFile(file.path, mimeType: mimeType),
      ], text: 'Exported schedule: ${schedule.name}');
    } catch (e) {
      throw Exception('Failed to save file: $e');
    }
  }
}
