import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:file_picker/file_picker.dart';
import '../providers/display_config_provider.dart';
import '../providers/table_theme_provider.dart';
import '../models/time.dart';
import '../models/weekday.dart';
import '../widgets/save_table_theme_dialog.dart';
import '../pages/table_themes_screen.dart';

/// Shows the table theme editing dialog.
void showTableThemeDialog(BuildContext context) {
  showDialog(context: context, builder: (context) => const TableThemeDialog());
}

/// Dialog for editing schedule table theme settings (colors, border, radius, etc.)
class TableThemeDialog extends StatelessWidget {
  const TableThemeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final displayConfig = context.watch<DisplayConfigProvider>();

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 700),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 8, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Table Theme',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(),

            // Scrollable settings list
            Flexible(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                shrinkWrap: true,
                children: [
                  ListTile(
                    leading: const Icon(Icons.schedule),
                    title: const Text('Time Range'),
                    subtitle: Text(
                      displayConfig.customStartTime != null
                          ? '${displayConfig.customStartTime!.format(displayConfig.is24HourFormat)} - ${displayConfig.customEndTime!.format(displayConfig.is24HourFormat)}'
                          : 'Auto-detect from schedule',
                    ),
                    trailing: displayConfig.customStartTime != null
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            tooltip: 'Reset to auto-detect',
                            onPressed: () {
                              displayConfig.clearTimeRange();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Time range reset to auto-detect',
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                          )
                        : null,
                    onTap: () => _showTimeRangePicker(context, displayConfig),
                  ),

                  ListTile(
                    leading: const Icon(Icons.color_lens),
                    title: const Text('Table Border Color'),
                    trailing: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: displayConfig.tableBorderColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                      ),
                    ),
                    onTap: () => _showColorPicker(
                      context,
                      'Table Border Color',
                      displayConfig.tableBorderColor,
                      (color) => displayConfig.updateTableBorderColor(color),
                    ),
                  ),

                  ListTile(
                    leading: const Icon(Icons.format_color_fill),
                    title: const Text('Table Background Color'),
                    trailing: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: displayConfig.tableBackgroundColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                      ),
                    ),
                    onTap: () => _showColorPicker(
                      context,
                      'Table Background Color',
                      displayConfig.tableBackgroundColor,
                      (color) =>
                          displayConfig.updateTableBackgroundColor(color),
                    ),
                  ),

                  ListTile(
                    leading: const Icon(Icons.rounded_corner),
                    title: const Text('Corner Radius'),
                    subtitle: Text(
                      '${displayConfig.cornerRadius.toStringAsFixed(0)} px',
                    ),
                    trailing: SizedBox(
                      width: 150,
                      child: Slider(
                        value: displayConfig.cornerRadius,
                        min: 0,
                        max: 30,
                        divisions: 30,
                        label: displayConfig.cornerRadius.toStringAsFixed(0),
                        onChanged: (value) {
                          displayConfig.updateCornerRadius(value);
                        },
                      ),
                    ),
                  ),

                  ListTile(
                    leading: const Icon(Icons.image),
                    title: const Text('Background Image'),
                    subtitle: Text(
                      displayConfig.backgroundImagePath != null
                          ? 'Image selected'
                          : 'No image',
                    ),
                    trailing: displayConfig.backgroundImagePath != null
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            tooltip: 'Remove image',
                            onPressed: () {
                              displayConfig.clearBackgroundImage();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Background image removed'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                          )
                        : null,
                    onTap: () => _pickBackgroundImage(context, displayConfig),
                  ),

                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: const Text('Weekday Colors'),
                    subtitle: const Text('Customize column colors'),
                    onTap: () =>
                        _showWeekdayColorPicker(context, displayConfig),
                  ),

                  const Divider(),

                  ListTile(
                    leading: const Icon(Icons.save),
                    title: const Text('Save Current Theme'),
                    subtitle: const Text(
                      'Save table customizations as a theme',
                    ),
                    onTap: () => _showSaveThemeDialog(context, displayConfig),
                  ),

                  ListTile(
                    leading: const Icon(Icons.palette),
                    title: const Text('Manage Saved Themes'),
                    subtitle: const Text('View and apply saved themes'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TableThemesScreen(),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.restore),
                    title: const Text('Reset to Defaults'),
                    subtitle: const Text('Restore default appearance'),
                    textColor: Colors.orange,
                    iconColor: Colors.orange,
                    onTap: () {
                      displayConfig.resetTableCustomizations();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Table customizations reset to defaults',
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTimeRangePicker(
    BuildContext context,
    DisplayConfigProvider displayConfig,
  ) {
    showDialog(
      context: context,
      builder: (context) =>
          _TimeRangePickerDialog(displayConfig: displayConfig),
    );
  }

  void _showColorPicker(
    BuildContext context,
    String title,
    Color currentColor,
    Function(Color) onColorChanged,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ColorPicker(
            color: currentColor,
            onColorChanged: onColorChanged,
            pickersEnabled: const {
              ColorPickerType.both: false,
              ColorPickerType.primary: true,
              ColorPickerType.accent: true,
              ColorPickerType.wheel: true,
            },
            enableOpacity: true,
            showColorCode: true,
            colorCodeHasColor: true,
            width: 44,
            height: 44,
            borderRadius: 4,
            heading: Text(
              'Select color',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickBackgroundImage(
    BuildContext context,
    DisplayConfigProvider displayConfig,
  ) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        displayConfig.setBackgroundImage(result.files.single.path);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Background image set'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        final errorMessage = e.toString().toLowerCase().contains('zenity')
            ? 'Error: zenity is not installed.\n\nTo fix this on Linux, run:\nsudo apt install zenity\n\nor use: sudo pacman -S zenity (Arch)\nor: sudo dnf install zenity (Fedora)'
            : 'Error picking image: $e';

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Image Picker Error'),
            content: SelectableText(errorMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  void _showWeekdayColorPicker(
    BuildContext context,
    DisplayConfigProvider displayConfig,
  ) {
    showDialog(
      context: context,
      builder: (context) =>
          _WeekdayColorPickerDialog(displayConfig: displayConfig),
    );
  }

  void _showSaveThemeDialog(
    BuildContext context,
    DisplayConfigProvider displayConfig,
  ) {
    showDialog(
      context: context,
      builder: (context) => SaveTableThemeDialog(
        onSave: (name) async {
          final themeProvider = context.read<TableThemeProvider>();
          try {
            await themeProvider.saveTheme(
              name: name,
              displayConfig: displayConfig,
            );
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Theme "$name" saved'),
                  behavior: SnackBarBehavior.floating,
                  action: SnackBarAction(
                    label: 'View',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TableThemesScreen(),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error saving theme: $e'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            }
          }
        },
      ),
    );
  }
}

/// Time range picker dialog
class _TimeRangePickerDialog extends StatefulWidget {
  final DisplayConfigProvider displayConfig;

  const _TimeRangePickerDialog({required this.displayConfig});

  @override
  State<_TimeRangePickerDialog> createState() => _TimeRangePickerDialogState();
}

class _TimeRangePickerDialogState extends State<_TimeRangePickerDialog> {
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;

  @override
  void initState() {
    super.initState();
    _startTime = widget.displayConfig.customStartTime != null
        ? TimeOfDay(
            hour: widget.displayConfig.customStartTime!.hour,
            minute: widget.displayConfig.customStartTime!.minute,
          )
        : const TimeOfDay(hour: 7, minute: 0);

    _endTime = widget.displayConfig.customEndTime != null
        ? TimeOfDay(
            hour: widget.displayConfig.customEndTime!.hour,
            minute: widget.displayConfig.customEndTime!.minute,
          )
        : const TimeOfDay(hour: 21, minute: 0);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Set Time Range'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Set custom start and end times for your schedule table.'),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text('Start Time'),
            subtitle: Text(_startTime.format(context)),
            onTap: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: _startTime,
              );
              if (time != null) {
                setState(() => _startTime = time);
              }
            },
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text('End Time'),
            subtitle: Text(_endTime.format(context)),
            onTap: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: _endTime,
              );
              if (time != null) {
                setState(() => _endTime = time);
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            final startMinutes = _startTime.hour * 60 + _startTime.minute;
            final endMinutes = _endTime.hour * 60 + _endTime.minute;

            if (startMinutes >= endMinutes) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Start time must be before end time'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              return;
            }

            widget.displayConfig.setTimeRange(
              Time(hour: _startTime.hour, minute: _startTime.minute),
              Time(hour: _endTime.hour, minute: _endTime.minute),
            );

            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Time range updated'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}

/// Weekday color picker dialog
class _WeekdayColorPickerDialog extends StatelessWidget {
  final DisplayConfigProvider displayConfig;

  const _WeekdayColorPickerDialog({required this.displayConfig});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Weekday Column Colors',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Customize the background color for each weekday column',
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: Weekday.values.map((weekday) {
                    return ListTile(
                      leading: Icon(
                        Icons.calendar_today,
                        color: displayConfig.weekdayColors[weekday],
                      ),
                      title: Text(weekday.fullName),
                      trailing: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: displayConfig.weekdayColors[weekday],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                      ),
                      onTap: () {
                        _showWeekdayColorPicker(
                          context,
                          weekday,
                          displayConfig,
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showWeekdayColorPicker(
    BuildContext context,
    Weekday weekday,
    DisplayConfigProvider displayConfig,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${weekday.fullName} Column Color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            color: displayConfig.weekdayColors[weekday]!,
            onColorChanged: (color) {
              displayConfig.updateWeekdayColor(weekday, color);
            },
            pickersEnabled: const {
              ColorPickerType.both: false,
              ColorPickerType.primary: true,
              ColorPickerType.accent: true,
              ColorPickerType.wheel: true,
            },
            enableOpacity: true,
            showColorCode: true,
            colorCodeHasColor: true,
            width: 44,
            height: 44,
            borderRadius: 4,
            heading: Text(
              'Select color',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
