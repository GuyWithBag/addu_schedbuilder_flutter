import 'package:flutter/material.dart';

/// Widget for displaying empty cells in the schedule grid
class ScheduleEmptyCell extends StatelessWidget {
  const ScheduleEmptyCell({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.3)),
      ),
      child: Center(
        child: Icon(
          Icons.circle,
          size: 4,
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
    );
  }
}
