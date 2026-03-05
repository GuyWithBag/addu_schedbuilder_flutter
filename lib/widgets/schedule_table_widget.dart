import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import '../models/schedule_table.dart';
import '../models/schedule_row.dart';
import '../models/time_slot.dart';
import '../models/weekday.dart';
import '../services/color_service.dart';
import '../providers/display_config_provider.dart';
import 'schedule_bar_cell.dart';
import 'schedule_class_cell.dart';
import 'schedule_empty_cell.dart';
import 'schedule_time_cell.dart';

/// Main widget for displaying the schedule table grid
class ScheduleTableWidget extends HookWidget {
  final ScheduleTable table;

  const ScheduleTableWidget({super.key, required this.table});

  @override
  Widget build(BuildContext context) {
    final displayConfig = context.watch<DisplayConfigProvider>();
    final theme = Theme.of(context);

    // Assign colors to classes
    final classes = table.getAllClasses();
    final classColors = useMemoized(() => ColorService.assignColors(classes), [
      classes.length,
    ]);

    // Update display config with colors
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        displayConfig.updateClassColors(classColors);
      });
      return null;
    }, [classColors]);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: RepaintBoundary(
          child: Container(
            decoration: BoxDecoration(
              color: displayConfig.tableBackgroundColor,
              image: displayConfig.backgroundImagePath != null
                  ? DecorationImage(
                      image: FileImage(
                        File(displayConfig.backgroundImagePath!),
                      ),
                      fit: BoxFit.cover,
                      opacity: 0.15,
                    )
                  : null,
              borderRadius: BorderRadius.circular(displayConfig.cornerRadius),
              border: Border.all(
                color: displayConfig.tableBorderColor,
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(displayConfig.cornerRadius),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row with weekdays
                  _buildHeaderRow(theme, displayConfig),
                  // Time slots
                  ...table.rows.map(
                    (row) => _buildTimeRow(
                      row,
                      displayConfig.is24HourFormat,
                      classColors,
                      theme,
                      displayConfig,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderRow(ThemeData theme, DisplayConfigProvider displayConfig) {
    return Row(
      children: [
        // Empty cell for time column
        Container(
          width: 80,
          height: 40,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            border: Border(
              right: BorderSide(color: displayConfig.tableBorderColor),
              bottom: BorderSide(
                color: displayConfig.tableBorderColor,
                width: 2,
              ),
            ),
          ),
          child: Center(
            child: Text(
              'Time',
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // Weekday headers
        ...Weekday.values.map((weekday) {
          final color = displayConfig.weekdayColors[weekday]!;
          return Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.3),
              border: Border(
                right: BorderSide(color: displayConfig.tableBorderColor),
                bottom: BorderSide(
                  color: displayConfig.tableBorderColor,
                  width: 2,
                ),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weekday.shortName,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color.withValues(alpha: 1.0),
                    ),
                  ),
                  Text(
                    weekday.fullName,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildTimeRow(
    ScheduleRow row,
    bool is24HourFormat,
    Map<String, ColorSet> classColors,
    ThemeData theme,
    DisplayConfigProvider displayConfig,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Time cell
        ScheduleTimeCell(
          time: row.time,
          is24HourFormat: is24HourFormat,
          duration: row.duration,
        ),
        // Day cells
        ...row.columns.asMap().entries.map<Widget>((entry) {
          final index = entry.key;
          final slot = entry.value;
          final weekday = Weekday.values[index];
          final weekdayColor = displayConfig.weekdayColors[weekday]!;

          if (slot == null) {
            return Container(
              width: 100,
              height: row.duration.toDouble(),
              decoration: BoxDecoration(
                color: weekdayColor.withValues(alpha: 0.1),
                border: Border(
                  right: BorderSide(color: displayConfig.tableBorderColor),
                  bottom: BorderSide(
                    color: displayConfig.tableBorderColor.withValues(
                      alpha: 0.3,
                    ),
                  ),
                ),
              ),
              child: const ScheduleEmptyCell(),
            );
          }

          if (slot is ClassSlot) {
            final colorSet = classColors[slot.classData.subject];
            return Container(
              width: 100.0 * slot.colspan,
              height: 60.0 * slot.rowspan,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: displayConfig.tableBorderColor),
                  bottom: BorderSide(
                    color: displayConfig.tableBorderColor.withValues(
                      alpha: 0.3,
                    ),
                  ),
                ),
              ),
              child: ScheduleClassCell(
                classData: slot.classData,
                rowspan: slot.rowspan,
                duration: slot.duration,
                colorSet: colorSet,
              ),
            );
          } else if (slot is BarSlot) {
            return Container(
              width: 100.0 * slot.colspan,
              height: 60.0 * slot.rowspan,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: displayConfig.tableBorderColor),
                  bottom: BorderSide(
                    color: displayConfig.tableBorderColor.withValues(
                      alpha: 0.3,
                    ),
                  ),
                ),
              ),
              child: ScheduleBarCell(label: slot.label),
            );
          } else {
            final emptySlot = slot as EmptySlot;
            return Container(
              width: 100.0 * emptySlot.colspan,
              height: 60.0 * emptySlot.rowspan,
              decoration: BoxDecoration(
                color: weekdayColor.withValues(alpha: 0.1),
                border: Border(
                  right: BorderSide(color: displayConfig.tableBorderColor),
                  bottom: BorderSide(
                    color: displayConfig.tableBorderColor.withValues(
                      alpha: 0.3,
                    ),
                  ),
                ),
              ),
              child: const ScheduleEmptyCell(),
            );
          }
        }),
      ],
    );
  }
}
