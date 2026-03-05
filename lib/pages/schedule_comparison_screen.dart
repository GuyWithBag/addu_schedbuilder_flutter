import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../models/saved_schedule.dart';
import '../models/time_block.dart';
import '../models/time.dart';
import '../models/weekday.dart';
import '../services/schedule_comparison_service.dart';

/// Screen for comparing multiple schedules
class ScheduleComparisonScreen extends HookWidget {
  final List<SavedSchedule> schedules;

  const ScheduleComparisonScreen({super.key, required this.schedules});

  @override
  Widget build(BuildContext context) {
    final selectedDay = useState<Weekday>(Weekday.monday);
    final showFreeTime = useState<bool>(true);
    final showBusyTime = useState<bool>(true);

    // Calculate free and busy time blocks
    final freeTimeBlocks = useMemoized(
      () => ScheduleComparisonService.findCommonFreeTime(
        schedules.map((s) => s.table).toList(),
      ),
      [schedules],
    );

    final busyTimeBlocks = useMemoized(() => _calculateBusyTime(schedules), [
      schedules,
    ]);

    // Filter blocks by selected day
    final filteredFreeBlocks = freeTimeBlocks
        .where((block) => block.weekday == selectedDay.value)
        .toList();

    final filteredBusyBlocks = busyTimeBlocks
        .where((block) => block.weekday == selectedDay.value)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Comparison'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showInfo(context),
            tooltip: 'About comparison',
          ),
        ],
      ),
      body: Column(
        children: [
          // Schedules being compared
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Comparing ${schedules.length} schedules:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: schedules.map((schedule) {
                    return Chip(
                      label: Text(schedule.name),
                      avatar: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(
                          schedule.name[0].toUpperCase(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Day selector
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: Weekday.values.map((day) {
                  final isSelected = selectedDay.value == day;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(day.shortName),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          selectedDay.value = day;
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Filter toggles
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: const Text('Free Time'),
                    value: showFreeTime.value,
                    onChanged: (value) => showFreeTime.value = value ?? true,
                    dense: true,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: const Text('Busy Time'),
                    value: showBusyTime.value,
                    onChanged: (value) => showBusyTime.value = value ?? true,
                    dense: true,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Time blocks list
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Free time blocks
                if (showFreeTime.value) ...[
                  _buildSectionHeader(
                    context,
                    'Common Free Time',
                    Icons.event_available,
                    Colors.green,
                  ),
                  if (filteredFreeBlocks.isEmpty)
                    _buildEmptyState(
                      'No common free time on ${selectedDay.value.fullName}',
                    )
                  else
                    ...filteredFreeBlocks.map(
                      (block) => _buildTimeBlockCard(
                        context,
                        block,
                        Colors.green,
                        true,
                      ),
                    ),
                  const SizedBox(height: 24),
                ],

                // Busy time blocks
                if (showBusyTime.value) ...[
                  _buildSectionHeader(
                    context,
                    'Busy Time (Someone has class)',
                    Icons.event_busy,
                    Colors.orange,
                  ),
                  if (filteredBusyBlocks.isEmpty)
                    _buildEmptyState(
                      'Everyone is free on ${selectedDay.value.fullName}',
                    )
                  else
                    ...filteredBusyBlocks.map(
                      (block) => _buildTimeBlockCard(
                        context,
                        block,
                        Colors.orange,
                        false,
                      ),
                    ),
                ],
              ],
            ),
          ),

          // Summary footer
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem(
                  context,
                  'Free Slots',
                  filteredFreeBlocks.length.toString(),
                  Colors.green,
                ),
                _buildSummaryItem(
                  context,
                  'Busy Slots',
                  filteredBusyBlocks.length.toString(),
                  Colors.orange,
                ),
                _buildSummaryItem(
                  context,
                  'Total Hours Free',
                  _calculateTotalHours(filteredFreeBlocks),
                  Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Text(
          message,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  Widget _buildTimeBlockCard(
    BuildContext context,
    TimeBlock block,
    Color color,
    bool isFreeTime,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: color.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_formatTime(block.startTime)} - ${_formatTime(block.endTime)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Duration: ${_formatDuration(block.durationMinutes)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isFreeTime ? Icons.check_circle : Icons.event_busy,
              color: color,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    String label,
    String value,
    Color color,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  String _formatTime(Time time) {
    final hours = time.hour;
    final mins = time.minute;
    final period = hours >= 12 ? 'PM' : 'AM';
    final displayHour = hours > 12 ? hours - 12 : (hours == 0 ? 12 : hours);
    return '${displayHour.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')} $period';
  }

  String _formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (hours > 0 && mins > 0) {
      return '${hours}h ${mins}m';
    } else if (hours > 0) {
      return '${hours}h';
    } else {
      return '${mins}m';
    }
  }

  String _calculateTotalHours(List<TimeBlock> blocks) {
    final totalMinutes = blocks.fold<int>(
      0,
      (sum, block) => sum + block.durationMinutes,
    );
    final hours = totalMinutes ~/ 60;
    final mins = totalMinutes % 60;
    if (hours > 0 && mins > 0) {
      return '${hours}h ${mins}m';
    } else if (hours > 0) {
      return '${hours}h';
    } else {
      return '${mins}m';
    }
  }

  List<TimeBlock> _calculateBusyTime(List<SavedSchedule> schedules) {
    final busyBlocks = <TimeBlock>[];
    final allClasses = <_ClassOccurrence>[];

    // Collect all class occurrences
    for (final schedule in schedules) {
      for (final classData in schedule.table.getAllClasses()) {
        for (final period in classData.schedule) {
          for (final weekday in period.weekdays) {
            allClasses.add(
              _ClassOccurrence(
                weekday: weekday,
                startMinutes: period.start.toMinutes(),
                endMinutes: period.end.toMinutes(),
                scheduleName: schedule.name,
              ),
            );
          }
        }
      }
    }

    // Group by weekday
    for (final weekday in Weekday.values) {
      final dayClasses = allClasses.where((c) => c.weekday == weekday).toList()
        ..sort((a, b) => a.startMinutes.compareTo(b.startMinutes));

      if (dayClasses.isEmpty) continue;

      // Merge overlapping time slots
      var currentStart = dayClasses.first.startMinutes;
      var currentEnd = dayClasses.first.endMinutes;

      for (var i = 1; i < dayClasses.length; i++) {
        final classOcc = dayClasses[i];
        if (classOcc.startMinutes <= currentEnd) {
          // Overlapping or adjacent, extend the current block
          currentEnd = currentEnd > classOcc.endMinutes
              ? currentEnd
              : classOcc.endMinutes;
        } else {
          // Gap found, save current block and start new one
          busyBlocks.add(
            TimeBlock(
              weekday: weekday,
              startTime: Time.fromMinutes(currentStart),
              endTime: Time.fromMinutes(currentEnd),
              isBusy: true,
            ),
          );
          currentStart = classOcc.startMinutes;
          currentEnd = classOcc.endMinutes;
        }
      }

      // Add the last block
      busyBlocks.add(
        TimeBlock(
          weekday: weekday,
          startTime: Time.fromMinutes(currentStart),
          endTime: Time.fromMinutes(currentEnd),
          isBusy: true,
        ),
      );
    }

    return busyBlocks;
  }

  void _showInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About Comparison'),
        content: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Common Free Time',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text('Time slots when ALL schedules are free.'),
              SizedBox(height: 16),
              Text('Busy Time', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('Time slots when at least one person has a class.'),
              SizedBox(height: 16),
              Text(
                'Use the day selector to view different weekdays.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }
}

class _ClassOccurrence {
  final Weekday weekday;
  final int startMinutes;
  final int endMinutes;
  final String scheduleName;

  _ClassOccurrence({
    required this.weekday,
    required this.startMinutes,
    required this.endMinutes,
    required this.scheduleName,
  });
}
