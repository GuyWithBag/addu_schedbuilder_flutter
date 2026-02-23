import 'package:flutter/material.dart';
import '../../domain/models/saved_schedule.dart';
import 'package:intl/intl.dart';

/// Card widget for displaying a saved schedule in the list
class SavedScheduleCard extends StatelessWidget {
  final SavedSchedule schedule;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const SavedScheduleCard({
    super.key,
    required this.schedule,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final classes = schedule.table.getAllClasses();
    final dateFormat = DateFormat('MMM d, yyyy');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with name and delete button
              Row(
                children: [
                  Expanded(
                    child: SelectableText(
                      schedule.name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: onDelete,
                    tooltip: 'Delete schedule',
                    color: Colors.red.shade400,
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Semester badge if available
              if (schedule.semester != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    schedule.semester!,
                    style: TextStyle(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],

              // Stats row
              Row(
                children: [
                  Icon(
                    Icons.event_note,
                    size: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  SelectableText(
                    '${classes.length} classes',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  SelectableText(
                    dateFormat.format(schedule.createdAt),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
