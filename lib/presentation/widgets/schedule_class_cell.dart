import 'package:flutter/material.dart';
import '../../domain/models/class_data.dart';
import '../../domain/services/color_service.dart';

/// Widget for displaying a class in the schedule grid
class ScheduleClassCell extends StatelessWidget {
  final ClassData classData;
  final int rowspan;
  final int duration;
  final ColorSet? colorSet;
  final VoidCallback? onTap;

  const ScheduleClassCell({
    super.key,
    required this.classData,
    required this.rowspan,
    required this.duration,
    this.colorSet,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Use provided color or default
    final bgColor = colorSet != null
        ? Color.fromARGB(
            colorSet!.primary.alpha,
            colorSet!.primary.red,
            colorSet!.primary.green,
            colorSet!.primary.blue,
          )
        : theme.colorScheme.primaryContainer;

    final textColor = colorSet != null
        ? Color.fromARGB(
            colorSet!.text.alpha,
            colorSet!.text.red,
            colorSet!.text.green,
            colorSet!.text.blue,
          )
        : theme.colorScheme.onPrimaryContainer;

    // Calculate font size based on duration
    final fontSize = duration >= 90 ? 14.0 : (duration >= 60 ? 12.0 : 10.0);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: theme.dividerColor),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              classData.code,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: textColor,
                fontSize: fontSize + 2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (duration >= 45) ...[
              const SizedBox(height: 2),
              Text(
                classData.subject,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: textColor,
                  fontSize: fontSize,
                ),
                maxLines: duration >= 90 ? 2 : 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (duration >= 60 && classData.schedule.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(
                classData.schedule.first.room,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: textColor.withOpacity(0.8),
                  fontSize: fontSize - 2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
