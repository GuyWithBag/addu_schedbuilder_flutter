import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../providers/display_config_provider.dart';
import '../providers/saved_schedules_provider.dart';
import '../providers/schedule_provider.dart';
import '../widgets/save_schedule_dialog.dart';
import '../widgets/schedule_results_view.dart';
import '../widgets/table_theme_dialog.dart';
import '../services/export_service.dart';
import '../models/saved_schedule.dart';

import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
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
                  hintMaxLines: 10,
                  hintText:
                      '''CS101 Computer Science Introduction to Programming * 8:00 AM - 9:30 AM Room 204 M W F * DOE, JOHN john.doe@example.com 3
                      MATH201 Mathematics Calculus I * 10:00 AM - 11:30 AM Room 305 T Th * SMITH, JANE jane.smith@example.edu 4
                      ENG102 English Composition II * 1:00 PM - 2:30 PM Room 101 M W * BROWN, ALICE alice.brown@example.com 3
                      PHYS101 Physics General Physics I * 3:00 PM - 4:30 PM Room 410 T Th * WILSON, BOB bob.wilson@example.com 4''',
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
                  onPressed: () => showTableThemeDialog(context),
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
      return ScheduleResultsView(
        scheduleTable: scheduleTable,
        repaintBoundaryKey: repaintBoundaryKey,
        isLoadedSchedule: provider.currentScheduleId != null,
        onSave: () => _showSaveDialog(context),
        onExport: () {
          final displayConfig = context.read<DisplayConfigProvider>();
          _showExportOptions(
            context,
            scheduleTable,
            repaintBoundaryKey,
            displayConfig.classColors,
          );
        },
        scrollController: scrollController,
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
      final savePath = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Schedule as PNG',
        fileName: 'schedule_${DateTime.now().millisecondsSinceEpoch}.png',
        type: FileType.image,
        bytes: bytes,
      );

      if (savePath == null) return; // User cancelled

      // On some platforms saveFile with bytes doesn't write, so write manually
      final file = File(savePath);
      if (!await file.exists()) {
        await file.writeAsBytes(bytes);
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Schedule saved to: $savePath'),
            behavior: SnackBarBehavior.floating,
          ),
        );
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

      final savePath = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Schedule as PDF',
        fileName: 'schedule_${DateTime.now().millisecondsSinceEpoch}.pdf',
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        bytes: bytes,
      );

      if (savePath == null) return;

      final file = File(savePath);
      if (!await file.exists()) {
        await file.writeAsBytes(bytes);
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Schedule saved to: $savePath'),
            behavior: SnackBarBehavior.floating,
          ),
        );
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
      final semesterStart = DateTime.now();
      final semesterEnd = semesterStart.add(const Duration(days: 120));

      final icsString = ExportService.exportToICS(
        scheduleTable,
        'My Schedule',
        semesterStart: semesterStart,
        semesterEnd: semesterEnd,
      );

      final icsBytes = Uint8List.fromList(icsString.codeUnits);
      final savePath = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Schedule as Calendar',
        fileName: 'schedule_${DateTime.now().millisecondsSinceEpoch}.ics',
        type: FileType.custom,
        allowedExtensions: ['ics'],
        bytes: icsBytes,
      );

      if (savePath == null) return;

      final file = File(savePath);
      if (!await file.exists()) {
        await file.writeAsString(icsString);
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Calendar saved to: $savePath'),
            behavior: SnackBarBehavior.floating,
          ),
        );
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
      final schedule = SavedSchedule(
        id: 'temp',
        name: 'Exported Schedule',
        createdAt: DateTime.now(),
        table: scheduleTable,
      );

      final jsonString = ExportService.exportToJSON(schedule);
      final jsonBytes = Uint8List.fromList(jsonString.codeUnits);

      final savePath = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Schedule as JSON',
        fileName: 'schedule_${DateTime.now().millisecondsSinceEpoch}.json',
        type: FileType.custom,
        allowedExtensions: ['json'],
        bytes: jsonBytes,
      );

      if (savePath == null) return;

      final file = File(savePath);
      if (!await file.exists()) {
        await file.writeAsString(jsonString);
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('JSON saved to: $savePath'),
            behavior: SnackBarBehavior.floating,
          ),
        );
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
