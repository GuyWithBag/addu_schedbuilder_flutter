import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import '../providers/saved_schedules_provider.dart';
import '../providers/schedule_provider.dart';
import '../providers/display_config_provider.dart';
import '../widgets/saved_schedule_card.dart';
import '../../domain/services/color_service.dart';
import '../../domain/models/theme_preset.dart';
import 'comparison_screen.dart';
import 'qr_scanner_screen.dart';
import 'home_screen.dart';
import '../widgets/qr_share_dialog.dart';

/// Screen displaying all saved schedules
class SavedSchedulesScreen extends HookWidget {
  const SavedSchedulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final savedSchedulesProvider = context.watch<SavedSchedulesProvider>();
    final allSchedules = savedSchedulesProvider.schedules;
    final isLoading = savedSchedulesProvider.isLoading;
    final selectedSemester = useState<String?>(null);

    // Load schedules on first build
    useEffect(() {
      Future.microtask(
        () => context.read<SavedSchedulesProvider>().loadSchedules(),
      );
      return null;
    }, []);

    // Filter schedules by semester
    final schedules =
        selectedSemester.value == null || selectedSemester.value!.isEmpty
        ? allSchedules
        : allSchedules
              .where((s) => s.semester == selectedSemester.value)
              .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Schedules'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            tooltip: 'Scan QR Code',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QrScannerScreen(),
                ),
              );
            },
          ),
          if (allSchedules.length >= 2)
            IconButton(
              icon: const Icon(Icons.compare_arrows),
              tooltip: 'Compare Schedules',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ComparisonScreen(),
                  ),
                );
              },
            ),
          if (allSchedules.isNotEmpty)
            PopupMenuButton<String>(
              icon: Icon(
                selectedSemester.value == null ||
                        selectedSemester.value!.isEmpty
                    ? Icons.filter_list
                    : Icons.filter_list_alt,
              ),
              tooltip: 'Filter by semester',
              onSelected: (semester) {
                selectedSemester.value = semester.isEmpty ? null : semester;
              },
              itemBuilder: (context) {
                final semesters = savedSchedulesProvider.getUniqueSemesters();
                return [
                  PopupMenuItem(
                    value: '',
                    child: Row(
                      children: [
                        if (selectedSemester.value == null ||
                            selectedSemester.value!.isEmpty)
                          const Icon(Icons.check, size: 20),
                        if (selectedSemester.value == null ||
                            selectedSemester.value!.isEmpty)
                          const SizedBox(width: 8),
                        const Text('All Semesters'),
                      ],
                    ),
                  ),
                  ...semesters.map(
                    (semester) => PopupMenuItem(
                      value: semester,
                      child: Row(
                        children: [
                          if (selectedSemester.value == semester)
                            const Icon(Icons.check, size: 20),
                          if (selectedSemester.value == semester)
                            const SizedBox(width: 8),
                          Text(semester),
                        ],
                      ),
                    ),
                  ),
                ];
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // Filter chip
          if (selectedSemester.value != null &&
              selectedSemester.value!.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Chip(
                    label: Text('Semester: ${selectedSemester.value}'),
                    onDeleted: () => selectedSemester.value = null,
                    deleteIcon: const Icon(Icons.close, size: 18),
                  ),
                  const Spacer(),
                  Text(
                    '${schedules.length} of ${allSchedules.length}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          // Content
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : schedules.isEmpty
                ? _buildEmptyState(context, selectedSemester.value)
                : _buildSchedulesList(context, schedules),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, String? filterSemester) {
    final isFiltered = filterSemester != null && filterSemester.isNotEmpty;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_month_outlined,
            size: 80,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            isFiltered
                ? 'No schedules for this semester'
                : 'No saved schedules',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isFiltered
                ? 'Try selecting a different semester'
                : 'Parse and save a schedule to see it here',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSchedulesList(BuildContext context, schedules) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        final schedule = schedules[index];
        return SavedScheduleCard(
          schedule: schedule,
          onTap: () => _loadSchedule(context, schedule.id),
          onDelete: () => _confirmDelete(context, schedule),
          onShare: () => _showQrCode(context, schedule),
          onCompare: () => _scanToCompare(context, schedule),
        );
      },
    );
  }

  Future<void> _loadSchedule(BuildContext context, String scheduleId) async {
    final savedSchedulesProvider = context.read<SavedSchedulesProvider>();
    final schedule = await savedSchedulesProvider.loadScheduleById(scheduleId);

    if (schedule == null) return;

    if (!context.mounted) return;

    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Apply Schedule'),
        content: Text(
          'Apply "${schedule.name}" to the schedule view?\n\n'
          'This will replace the current schedule being displayed.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Apply'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    final scheduleProvider = context.read<ScheduleProvider>();

    // Load the schedule table into ScheduleProvider with the schedule ID and input text
    scheduleProvider.loadScheduleTable(
      schedule.table,
      scheduleId: schedule.id,
      inputText: schedule.inputText,
    );

    // Apply theme preset if available
    if (schedule.themePreset != null) {
      final displayConfig = context.read<DisplayConfigProvider>();
      final themePreset = schedule.themePreset!;

      // Apply class colors
      for (final entry in themePreset.classColors.entries) {
        final colorData = entry.value;
        displayConfig.updateClassColor(
          entry.key,
          ColorSet(
            primary: colorData,
            light: ColorData(
              red: (colorData.red + (255 - colorData.red) * 0.2).round().clamp(
                0,
                255,
              ),
              green: (colorData.green + (255 - colorData.green) * 0.2)
                  .round()
                  .clamp(0, 255),
              blue: (colorData.blue + (255 - colorData.blue) * 0.2)
                  .round()
                  .clamp(0, 255),
              alpha: colorData.alpha,
            ),
            dark: ColorData(
              red: (colorData.red * 0.8).round().clamp(0, 255),
              green: (colorData.green * 0.8).round().clamp(0, 255),
              blue: (colorData.blue * 0.8).round().clamp(0, 255),
              alpha: colorData.alpha,
            ),
            text: const ColorData(red: 255, green: 255, blue: 255, alpha: 255),
          ),
        );
      }
    }

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Applied "${schedule.name}"'),
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Navigate to input screen (home page) to show the loaded schedule
      if (context.mounted) {
        // Use the home screen navigator to switch to the input/schedule tab
        final navigatorState = HomeScreen.navigatorKey.currentState;
        navigatorState?.navigateToTab(
          0,
        ); // Index 0 is the input screen (shows schedule)
      }
    }
  }

  Future<void> _confirmDelete(BuildContext context, schedule) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Schedule'),
        content: Text('Are you sure you want to delete "${schedule.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      // Store the schedule for undo functionality
      final deletedSchedule = schedule;

      try {
        await context.read<SavedSchedulesProvider>().deleteSchedule(
          schedule.id,
        );

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Deleted "${schedule.name}"'),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 5),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () async {
                  // Restore the deleted schedule
                  try {
                    // Extract colors from the deleted schedule's theme preset or regenerate
                    Map<String, ColorSet> classColors;

                    if (deletedSchedule.themePreset != null) {
                      // Convert ColorData back to ColorSet
                      classColors = {};
                      for (final entry
                          in deletedSchedule.themePreset!.classColors.entries) {
                        final colorData = entry.value;
                        classColors[entry.key] = ColorSet(
                          primary: colorData,
                          light: ColorData(
                            red: (colorData.red + (255 - colorData.red) * 0.2)
                                .round()
                                .clamp(0, 255),
                            green:
                                (colorData.green +
                                        (255 - colorData.green) * 0.2)
                                    .round()
                                    .clamp(0, 255),
                            blue:
                                (colorData.blue + (255 - colorData.blue) * 0.2)
                                    .round()
                                    .clamp(0, 255),
                            alpha: colorData.alpha,
                          ),
                          dark: ColorData(
                            red: (colorData.red * 0.8).round().clamp(0, 255),
                            green: (colorData.green * 0.8).round().clamp(
                              0,
                              255,
                            ),
                            blue: (colorData.blue * 0.8).round().clamp(0, 255),
                            alpha: colorData.alpha,
                          ),
                          text: const ColorData(
                            red: 255,
                            green: 255,
                            blue: 255,
                            alpha: 255,
                          ),
                        );
                      }
                    } else {
                      // Regenerate colors
                      final classes = deletedSchedule.table.getAllClasses();
                      classColors = ColorService.assignColors(classes);
                    }

                    await context.read<SavedSchedulesProvider>().saveSchedule(
                      deletedSchedule.name,
                      deletedSchedule.table,
                      deletedSchedule.semester,
                      classColors,
                      id: deletedSchedule.id,
                    );

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Restored "${deletedSchedule.name}"'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error restoring schedule: $e'),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error deleting schedule: $e'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    }
  }

  void _showQrCode(BuildContext context, dynamic schedule) {
    showDialog(
      context: context,
      builder: (context) => QrShareDialog(schedule: schedule),
    );
  }

  void _scanToCompare(BuildContext context, dynamic schedule) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            QrScannerScreen(comparisonMode: true, mySchedule: schedule),
      ),
    );
  }
}
