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
import '../widgets/class_info_table.dart';
import '../services/export_service.dart';
import '../models/saved_schedule.dart';
import '../models/schedule_table.dart';
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

    // Sync text controller with provider's inputText
    useEffect(() {
      if (textController.text != scheduleProvider.inputText) {
        textController.text = scheduleProvider.inputText;
      }
      return null;
    }, [scheduleProvider.inputText]);

    final bool hasParsedResult = scheduleProvider.parseResult != null;
    final bool hasTable =
        scheduleProvider.scheduleTable != null &&
        !scheduleProvider.scheduleTable!.isEmpty;
    final bool isSuccess =
        hasTable ||
        (hasParsedResult && scheduleProvider.parseResult!.isSuccess);

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
            Expanded(
              child: TextField(
                controller: textController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
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
            ),
            const SizedBox(height: 16),

            // Parse button and Theme Edit button row
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: scheduleProvider.isLoading
                        ? null
                        : () async {
                            await scheduleProvider.parseAndArrange();
                            if (context.mounted) {
                              _showResultsSheet(
                                context,
                                scheduleProvider,
                                repaintBoundaryKey,
                              );
                            }
                          },
                    icon: scheduleProvider.isLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.play_arrow),
                    label: Text(
                      scheduleProvider.isLoading
                          ? 'Parsing...'
                          : 'Parse Schedule',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filledTonal(
                  onPressed: () {
                    // TODO: Implement theme editing function
                  },
                  icon: const Icon(Icons.color_lens),
                  tooltip: 'Edit Table Theme',
                ),
              ],
            ),

            // Conditional OutlinedButton for results/error
            if (hasParsedResult || hasTable) ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () => _showResultsSheet(
                  context,
                  scheduleProvider,
                  repaintBoundaryKey,
                ),
                icon: Icon(
                  isSuccess ? Icons.check_circle_outline : Icons.error_outline,
                  color: isSuccess ? Colors.green : Colors.red,
                ),
                label: Text(isSuccess ? 'Show Results' : 'Show Error'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: isSuccess
                      ? Colors.green.shade700
                      : Colors.red.shade700,
                  side: BorderSide(
                    color: isSuccess ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showResultsSheet(
    BuildContext context,
    ScheduleProvider provider,
    GlobalKey repaintBoundaryKey,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (sheetContext) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 1.0,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Column(
              children: [
                // Drag handle and JSON Action
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    right: 8.0,
                    left: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Results',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.data_object),
                            tooltip: 'Show JSON',
                            onPressed: () {
                              // TODO: Implement show JSON function
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                // Results content
                Expanded(
                  child: _buildResultsContent(
                    context,
                    provider,
                    repaintBoundaryKey,
                    scrollController,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildResultsContent(
    BuildContext context,
    ScheduleProvider provider,
    GlobalKey repaintBoundaryKey,
    ScrollController scrollController,
  ) {
    final parseResult = provider.parseResult;
    final scheduleTable = provider.scheduleTable;

    // If we have a schedule table (either parsed or loaded), show it
    if (scheduleTable != null && !scheduleTable.isEmpty) {
      return _buildScheduleView(
        context,
        scheduleTable,
        repaintBoundaryKey,
        provider.currentScheduleId != null,
        scrollController,
      );
    }

    // No schedule table yet
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
        controller: scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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

    // This code should never be reached now, but keep it for safety
    return const Center(child: Text('No schedule to display'));
  }

  Widget _buildScheduleView(
    BuildContext context,
    ScheduleTable scheduleTable,
    GlobalKey repaintBoundaryKey,
    bool isLoadedSchedule,
    ScrollController scrollController,
  ) {
    final classes = scheduleTable.getAllClasses();

    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Success banner with save button
          Card(
            color: isLoadedSchedule
                ? Colors.blue.shade50
                : Colors.green.shade50,
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Icon(
                    isLoadedSchedule ? Icons.folder_open : Icons.check_circle,
                    color: isLoadedSchedule ? Colors.blue : Colors.green,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      isLoadedSchedule
                          ? 'Loaded schedule (${classes.length} classes)'
                          : 'Successfully parsed ${classes.length} classes!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isLoadedSchedule
                            ? Colors.blue.shade900
                            : Colors.green,
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
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Class Information',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  ClassInfoTable(scheduleTable: scheduleTable),
                ],
              ),
            ),
          ),
          // Conflict Detection
          ConflictIndicatorWidget(table: scheduleTable),
          // Statistics
          StatisticsWidget(table: scheduleTable),
          const SizedBox(height: 24), // Extra bottom padding
        ],
      ),
    );
  }

  void _showSaveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => SaveScheduleDialog(
        existingSchedules: context.read<SavedSchedulesProvider>().schedules,
        currentScheduleId: context.read<ScheduleProvider>().currentScheduleId,
        onSave: (name, semester, {String? overwriteId}) async {
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
              id: overwriteId, // Pass the overwrite ID if provided
              inputText:
                  scheduleProvider.inputText, // Save the original input text
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
                    await _exportICS(context, scheduleTable);
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Calendar (.ics)'),
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

      // For desktop platforms, save to Downloads folder
      if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
        final downloadsDir = Directory(
          '/home/${Platform.environment['USER']}/Downloads',
        );
        if (!await downloadsDir.exists()) {
          await downloadsDir.create(recursive: true);
        }
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final file = File('${downloadsDir.path}/schedule_$timestamp.png');
        await file.writeAsBytes(bytes);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Schedule saved to: ${file.path}'),
              behavior: SnackBarBehavior.floating,
              action: SnackBarAction(
                label: 'Open Folder',
                onPressed: () {
                  // User can manually open the Downloads folder
                },
              ),
            ),
          );
        }
      } else {
        // For mobile, use share
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
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: SelectableText('Error exporting PNG: $e'),
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
      // Convert Map<String, ColorSet> to Map<String, Color>
      final colorMap = <String, Color>{};
      classColors.forEach((String key, value) {
        // value is ColorSet, value.primary is ColorData
        final colorData = value.primary;
        colorMap[key] = Color.fromARGB(
          colorData.alpha,
          colorData.red,
          colorData.green,
          colorData.blue,
        );
      });

      final bytes = await ExportService.exportToPDF(
        scheduleTable,
        colorMap,
        'My Schedule',
      );

      // For desktop platforms, save to Downloads folder
      if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
        final downloadsDir = Directory(
          '/home/${Platform.environment['USER']}/Downloads',
        );
        if (!await downloadsDir.exists()) {
          await downloadsDir.create(recursive: true);
        }
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final file = File('${downloadsDir.path}/schedule_$timestamp.pdf');
        await file.writeAsBytes(bytes);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Schedule saved to: ${file.path}'),
              behavior: SnackBarBehavior.floating,
              action: SnackBarAction(
                label: 'Open Folder',
                onPressed: () {
                  // User can manually open the Downloads folder
                },
              ),
            ),
          );
        }
      } else {
        // For mobile, use share
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
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: SelectableText('Error exporting PDF: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _exportICS(BuildContext context, scheduleTable) async {
    try {
      // Default semester dates (current date + 4 months)
      final semesterStart = DateTime.now();
      final semesterEnd = semesterStart.add(const Duration(days: 120));

      final icsString = ExportService.exportToICS(
        scheduleTable,
        'My Schedule',
        semesterStart: semesterStart,
        semesterEnd: semesterEnd,
      );

      // For desktop platforms, save to Downloads folder
      if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
        final downloadsDir = Directory(
          '/home/${Platform.environment['USER']}/Downloads',
        );
        if (!await downloadsDir.exists()) {
          await downloadsDir.create(recursive: true);
        }
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final file = File('${downloadsDir.path}/schedule_$timestamp.ics');
        await file.writeAsString(icsString);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Calendar file saved to: ${file.path}'),
              behavior: SnackBarBehavior.floating,
              action: SnackBarAction(
                label: 'Open Folder',
                onPressed: () {
                  // User can manually open the Downloads folder
                },
              ),
            ),
          );
        }
      } else {
        // For mobile, use share
        final directory = await getTemporaryDirectory();
        final file = File('${directory.path}/schedule.ics');
        await file.writeAsString(icsString);

        await Share.shareXFiles([
          XFile(file.path, mimeType: 'text/calendar'),
        ], text: 'My Schedule - Import to Calendar');

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Schedule exported as Calendar file (.ics)!'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: SelectableText('Error exporting calendar: $e'),
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

      // For desktop platforms, save to Downloads folder
      if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
        final downloadsDir = Directory(
          '/home/${Platform.environment['USER']}/Downloads',
        );
        if (!await downloadsDir.exists()) {
          await downloadsDir.create(recursive: true);
        }
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final file = File('${downloadsDir.path}/schedule_$timestamp.json');
        await file.writeAsString(jsonString);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('JSON file saved to: ${file.path}'),
              behavior: SnackBarBehavior.floating,
              action: SnackBarAction(
                label: 'Open Folder',
                onPressed: () {
                  // User can manually open the Downloads folder
                },
              ),
            ),
          );
        }
      } else {
        // For mobile, use share
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
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: SelectableText('Error exporting JSON: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}
