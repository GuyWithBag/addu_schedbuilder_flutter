import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/class_data.dart';
import '../services/color_service.dart';
import '../providers/notes_provider.dart';
import 'class_notes_dialog.dart';

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
    final notesProvider = context.watch<NotesProvider>();
    final notes = notesProvider.getNotesForClass(classData.code);
    final hasNotes = notes.isNotEmpty;

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
      onTap:
          onTap ??
          () {
            showDialog(
              context: context,
              builder: (context) => ClassNotesDialog(classData: classData),
            );
          },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: bgColor,
              border: Border.all(color: theme.dividerColor),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    classData.code,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      fontSize: fontSize + 1,
                      height: 1.0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (duration >= 45) ...[
                    const SizedBox(height: 1),
                    Text(
                      classData.subject,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: textColor,
                        fontSize: fontSize - 1,
                        height: 1.0,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (duration >= 75 && classData.schedule.isNotEmpty) ...[
                    const SizedBox(height: 1),
                    Text(
                      classData.schedule.first.room,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: textColor.withValues(alpha: 0.8),
                        fontSize: fontSize - 2,
                        height: 1.0,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Notes badge indicator
          if (hasNotes)
            Positioned(
              top: 2,
              right: 2,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary,
                  shape: BoxShape.circle,
                  border: Border.all(color: bgColor, width: 1),
                ),
                child: Icon(
                  Icons.note,
                  size: 10,
                  color: theme.colorScheme.onSecondary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
