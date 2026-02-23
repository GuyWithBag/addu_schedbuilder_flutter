import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import '../../domain/models/schedule_table.dart';
import '../../domain/models/schedule_row.dart';
import '../../domain/models/weekday.dart';
import '../../domain/services/color_service.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row with weekdays
              _buildHeaderRow(theme),
              // Time slots
              ...table.rows.map(
                (row) => _buildTimeRow(
                  row,
                  displayConfig.is24HourFormat,
                  classColors,
                  theme,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderRow(ThemeData theme) {
    return Row(
      children: [
        // Empty cell for time column
        Container(
          width: 80,
          height: 40,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            border: Border(
              right: BorderSide(color: theme.dividerColor),
              bottom: BorderSide(color: theme.dividerColor, width: 2),
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
          final color = ColorService.getWeekdayColor(weekday);
          return Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
              color: Color.fromARGB(50, color.red, color.green, color.blue),
              border: Border(
                right: BorderSide(color: theme.dividerColor),
                bottom: BorderSide(color: theme.dividerColor, width: 2),
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
                      color: Color.fromARGB(
                        255,
                        color.red,
                        color.green,
                        color.blue,
                      ),
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
        ...row.columns.map<Widget>((slot) {
          if (slot == null) {
            return SizedBox(
              width: 100,
              height: row.duration.toDouble(),
              child: const ScheduleEmptyCell(),
            );
          }

          return slot.when(
            classSlot: (classData, rowspan, colspan, duration) {
              final colorSet = classColors[classData.subject];
              return SizedBox(
                width: 100.0 * colspan,
                height: 60.0 * rowspan,
                child: ScheduleClassCell(
                  classData: classData,
                  rowspan: rowspan,
                  duration: duration,
                  colorSet: colorSet,
                ),
              );
            },
            barSlot: (label, rowspan, colspan) {
              return SizedBox(
                width: 100.0 * colspan,
                height: 60.0 * rowspan,
                child: ScheduleBarCell(label: label),
              );
            },
            emptySlot: (rowspan, colspan) {
              return SizedBox(
                width: 100.0 * colspan,
                height: 60.0 * rowspan,
                child: const ScheduleEmptyCell(),
              );
            },
          );
        }),
      ],
    );
  }
}
