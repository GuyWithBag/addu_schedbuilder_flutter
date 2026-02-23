import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import '../../domain/models/conflict_info.dart';
import '../../domain/models/schedule_table.dart';
import '../../domain/models/weekday.dart';
import '../../domain/services/conflict_detection_service.dart';
import '../providers/display_config_provider.dart';

/// Widget for displaying schedule conflicts
class ConflictIndicatorWidget extends HookWidget {
  final ScheduleTable table;

  const ConflictIndicatorWidget({super.key, required this.table});

  @override
  Widget build(BuildContext context) {
    final conflicts = ConflictDetectionService.detectConflicts(table);
    final isExpanded = useState(false);
    final displayConfig = context.watch<DisplayConfigProvider>();
    final is24Hour = displayConfig.is24HourFormat;

    if (conflicts.isEmpty) {
      return Card(
        color: Colors.green.shade50,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green.shade700),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'No scheduling conflicts detected',
                  style: TextStyle(
                    color: Colors.green.shade900,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      color: Colors.red.shade50,
      child: Column(
        children: [
          InkWell(
            onTap: () => isExpanded.value = !isExpanded.value,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.warning, color: Colors.red.shade700),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '${conflicts.length} scheduling conflict${conflicts.length > 1 ? 's' : ''} detected',
                      style: TextStyle(
                        color: Colors.red.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded.value ? Icons.expand_less : Icons.expand_more,
                    color: Colors.red.shade700,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded.value) ...[
            const Divider(height: 1),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: conflicts.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final conflict = conflicts[index];
                return _ConflictCard(
                  conflict: conflict,
                  conflictNumber: index + 1,
                  is24Hour: is24Hour,
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}

class _ConflictCard extends StatelessWidget {
  final ConflictInfo conflict;
  final int conflictNumber;
  final bool is24Hour;

  const _ConflictCard({
    required this.conflict,
    required this.conflictNumber,
    required this.is24Hour,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Conflict header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red.shade700,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Conflict #$conflictNumber',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade300),
                ),
                child: Text(
                  _getWeekdayName(conflict.weekday),
                  style: TextStyle(
                    color: Colors.orange.shade900,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Overlap time
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.red.shade700),
              const SizedBox(width: 8),
              Text(
                'Overlap: ${conflict.startTime.format(is24Hour)} - ${conflict.endTime.format(is24Hour)}',
                style: TextStyle(
                  color: Colors.red.shade900,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Conflicting classes
          Text(
            'Conflicting Classes:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red.shade900,
            ),
          ),
          const SizedBox(height: 8),
          ...conflict.conflictingClasses.map((classData) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      classData.code,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(classData.title, style: theme.textTheme.bodySmall),
                    if (classData.schedule.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        classData.schedule
                            .where((p) => p.weekdays.contains(conflict.weekday))
                            .map(
                              (p) =>
                                  '${p.start.format(is24Hour)} - ${p.end.format(is24Hour)} (${p.room})',
                            )
                            .join(', '),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),

          // Resolution suggestions
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  size: 16,
                  color: Colors.blue.shade700,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Consider rescheduling one of these classes to a different time or day.',
                    style: TextStyle(fontSize: 12, color: Colors.blue.shade900),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getWeekdayName(Weekday day) {
    switch (day) {
      case Weekday.sunday:
        return 'Sunday';
      case Weekday.monday:
        return 'Monday';
      case Weekday.tuesday:
        return 'Tuesday';
      case Weekday.wednesday:
        return 'Wednesday';
      case Weekday.thursday:
        return 'Thursday';
      case Weekday.friday:
        return 'Friday';
      case Weekday.saturday:
        return 'Saturday';
    }
  }
}
