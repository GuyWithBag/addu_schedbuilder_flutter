import 'package:flutter/material.dart';
import '../models/schedule_table.dart';
import 'schedule_table_widget.dart';
import 'statistics_widget.dart';
import 'conflict_indicator_widget.dart';
import 'class_info_table.dart';

/// Displays the parsed schedule results: banner, table, class info,
/// conflicts, and statistics.
class ScheduleResultsView extends StatelessWidget {
  const ScheduleResultsView({
    super.key,
    required this.scheduleTable,
    required this.repaintBoundaryKey,
    required this.isLoadedSchedule,
    required this.onSave,
    required this.onExport,
    this.scrollController,
  });

  final ScheduleTable scheduleTable;
  final GlobalKey repaintBoundaryKey;
  final bool isLoadedSchedule;
  final VoidCallback onSave;
  final VoidCallback onExport;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
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
            margin: EdgeInsets.zero,
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
                    onPressed: onSave,
                    icon: const Icon(Icons.save),
                    label: const Text('Save'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton.tonalIcon(
                    onPressed: onExport,
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

          // Class Information
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

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
