import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import '../providers/display_config_provider.dart';
import '../providers/saved_schedules_provider.dart';
import '../providers/schedule_provider.dart';
import '../widgets/save_schedule_dialog.dart';
import '../widgets/schedule_table_widget.dart';
import '../widgets/statistics_widget.dart';
import '../widgets/conflict_indicator_widget.dart';
import '../../domain/services/export_service.dart';
import '../../domain/models/saved_schedule.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'home_screen.dart';

/// Screen for inputting and parsing schedule text
class InputScreen extends HookWidget {
  const InputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = context.watch<ScheduleProvider>();
    final textController = useTextEditingController();
    final repaintBoundaryKey = useMemoized(() => GlobalKey());

    return Scaffold(
      appBar: AppBar(
        title: const Text('SchedBuilder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              context.read<DisplayConfigProvider>().toggleDarkMode();
            },
            tooltip: 'Toggle dark mode',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input field
            TextField(
              controller: textController,
              maxLines: 10,
              decoration: const InputDecoration(
                labelText: 'Paste Schedule Text',
                hintText:
                    'CS101 Computer Science Intro * 8:00 AM - 9:30 AM Room 204 M W F * DOE, JOHN john@example.com 3',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                scheduleProvider.updateInput(value);
              },
            ),

            const SizedBox(height: 16),

            // Parse button
            ElevatedButton.icon(
              onPressed: scheduleProvider.isLoading
                  ? null
                  : () {
                      scheduleProvider.parseAndArrange();
                    },
              icon: scheduleProvider.isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.play_arrow),
              label: Text(
                scheduleProvider.isLoading ? 'Parsing...' : 'Parse Schedule',
              ),
            ),

            const SizedBox(height: 16),

            // Results
            Expanded(
              child: _buildResults(
                context,
                scheduleProvider,
                repaintBoundaryKey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResults(
    BuildContext context,
    ScheduleProvider provider,
    GlobalKey repaintBoundaryKey,
  ) {
    final parseResult = provider.parseResult;
    final scheduleTable = provider.scheduleTable;

    if (parseResult == null) {
      return const Center(
        child: Text(
          'Enter schedule text and tap Parse',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    if (!parseResult.isSuccess) {
      return SingleChildScrollView(
        child: Card(
          color: Colors.red.shade50,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.error, color: Colors.red),
                    const SizedBox(width: 8),
                    SelectableText(
                      'Parsing Errors:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ...parseResult.errors!.map(
                  (error) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: SelectableText('• $error'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (scheduleTable == null || scheduleTable.isEmpty) {
      return const Center(child: Text('No schedule to display'));
    }

    // Success! Show schedule table
    final classes = scheduleTable.getAllClasses();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Success banner with save button
          Card(
            color: Colors.green.shade50,
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Successfully parsed ${classes.length} classes!',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: () => _showSaveDialog(context),
                    icon: const Icon(Icons.save),
                    label: const Text('Save'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton.tonalIcon(
                    onPressed: () {
                      final displayConfig = context
                          .read<DisplayConfigProvider>();
                      _showExportOptions(
                        context,
                        scheduleTable,
                        repaintBoundaryKey,
                        displayConfig.classColors,
                      );
                    },
                    icon: const Icon(Icons.share),
                    label: const Text('Export'),
                  ),
                ],
              ),
            ),
          ),
          // Schedule Table
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weekly Schedule',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  RepaintBoundary(
                    key: repaintBoundaryKey,
                    child: ScheduleTableWidget(table: scheduleTable),
                  ),
                ],
              ),
            ),
          ),

          // Conflict Detection
          const SizedBox(height: 16),
          ConflictIndicatorWidget(table: scheduleTable),

          // Statistics
          const SizedBox(height: 16),
          StatisticsWidget(table: scheduleTable),
        ],
      ),
    );
  }

  void _showSaveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => SaveScheduleDialog(
        onSave: (name, semester) async {
          final scheduleProvider = context.read<ScheduleProvider>();
          final savedSchedulesProvider = context.read<SavedSchedulesProvider>();
          final displayConfigProvider = context.read<DisplayConfigProvider>();

          final scheduleTable = scheduleProvider.scheduleTable;
          if (scheduleTable == null) return;

          try {
            await savedSchedulesProvider.saveSchedule(
              name,
              scheduleTable,
              semester,
              displayConfigProvider.classColors,
            );

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Schedule "$name" saved successfully!'),
                  behavior: SnackBarBehavior.floating,
                  action: SnackBarAction(
                    label: 'View',
                    onPressed: () {
                      // Navigate to saved schedules screen (tab index 1)
                      HomeScreen.navigatorKey.currentState?.navigateToTab(1);
                    },
                  ),
                ),
              );
            }
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error saving schedule: $e'),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          }
        },
      ),
    );
  }

  void _showExportOptions(
    BuildContext context,
    scheduleTable,
    GlobalKey repaintBoundaryKey,
    classColors,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Export Schedule',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FilledButton.tonalIcon(
                  onPressed: () async {
                    Navigator.pop(context);
                    await _exportPNG(context, repaintBoundaryKey);
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('PNG'),
                ),
                FilledButton.tonalIcon(
                  onPressed: () async {
                    Navigator.pop(context);
                    await _exportPDF(context, scheduleTable, classColors);
                  },
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('PDF'),
                ),
                FilledButton.tonalIcon(
                  onPressed: () async {
                    Navigator.pop(context);
                    await _exportJSON(context, scheduleTable);
                  },
                  icon: const Icon(Icons.code),
                  label: const Text('JSON'),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Future<void> _exportPNG(BuildContext context, GlobalKey key) async {
    try {
      final bytes = await ExportService.exportToPNG(key);
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/schedule.png');
      await file.writeAsBytes(bytes);

      await Share.shareXFiles([
        XFile(file.path, mimeType: 'image/png'),
      ], text: 'My Schedule');

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

  Future<void> _exportPDF(
    BuildContext context,
    scheduleTable,
    classColors,
  ) async {
    try {
      final bytes = await ExportService.exportToPDF(
        scheduleTable,
        classColors.map<String, Color>(
          (key, value) => MapEntry(key, value.primary),
        ),
        'My Schedule',
      );

      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/schedule.pdf');
      await file.writeAsBytes(bytes);

      await Share.shareXFiles([
        XFile(file.path, mimeType: 'application/pdf'),
      ], text: 'My Schedule');

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

  Future<void> _exportJSON(BuildContext context, scheduleTable) async {
    try {
      // Create a temporary SavedSchedule for export
      final schedule = SavedSchedule(
        id: 'temp',
        name: 'Exported Schedule',
        createdAt: DateTime.now(),
        table: scheduleTable,
      );

      final jsonString = ExportService.exportToJSON(schedule);
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/schedule.json');
      await file.writeAsString(jsonString);

      await Share.shareXFiles([
        XFile(file.path, mimeType: 'application/json'),
      ], text: 'My Schedule (JSON)');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Schedule exported as JSON!'),
            behavior: SnackBarBehavior.floating,
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
}
