import 'package:flutter/material.dart';
import '../../domain/models/time.dart';

/// Widget for displaying time in the left column of the schedule
class ScheduleTimeCell extends StatelessWidget {
  final Time time;
  final bool is24HourFormat;
  final int duration;

  const ScheduleTimeCell({
    super.key,
    required this.time,
    required this.is24HourFormat,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isNoon = time.hour == 12 && time.minute == 0;

    return Container(
      width: 80,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isNoon ? theme.colorScheme.primaryContainer : null,
        border: Border(
          right: BorderSide(color: theme.dividerColor),
          bottom: BorderSide(color: theme.dividerColor),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time.format(is24HourFormat),
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: isNoon ? FontWeight.bold : FontWeight.normal,
              color: isNoon ? theme.colorScheme.onPrimaryContainer : null,
            ),
          ),
          if (duration > 0)
            Text(
              '${duration}m',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
        ],
      ),
    );
  }
}
