import 'package:flutter/material.dart';
import '../../domain/models/theme_preset.dart';
import '../../domain/models/time.dart';
import '../../domain/models/weekday.dart';
import '../../domain/services/color_service.dart';

/// Provider for managing display configuration (colors, dark mode, time format)
class DisplayConfigProvider extends ChangeNotifier {
  Map<String, ColorSet> _classColors = {};
  bool _isDarkMode = false;
  bool _is24HourFormat = false;
  Time? _customStartTime;
  Time? _customEndTime;

  // Table customization
  Color _tableBorderColor = Colors.grey;
  Color _tableBackgroundColor = Colors.white;
  double _cornerRadius = 8.0;
  String? _backgroundImagePath;
  Map<Weekday, Color> _weekdayColors = {
    Weekday.monday: Colors.blue.shade100,
    Weekday.tuesday: Colors.green.shade100,
    Weekday.wednesday: Colors.orange.shade100,
    Weekday.thursday: Colors.purple.shade100,
    Weekday.friday: Colors.red.shade100,
    Weekday.saturday: Colors.teal.shade100,
    Weekday.sunday: Colors.pink.shade100,
  };

  Map<String, ColorSet> get classColors => _classColors;
  bool get isDarkMode => _isDarkMode;
  bool get is24HourFormat => _is24HourFormat;
  Time? get customStartTime => _customStartTime;
  Time? get customEndTime => _customEndTime;
  Color get tableBorderColor => _tableBorderColor;
  Color get tableBackgroundColor => _tableBackgroundColor;
  double get cornerRadius => _cornerRadius;
  String? get backgroundImagePath => _backgroundImagePath;
  Map<Weekday, Color> get weekdayColors => _weekdayColors;

  /// Toggle dark mode
  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  /// Toggle 24-hour time format
  void toggle24HourFormat() {
    _is24HourFormat = !_is24HourFormat;
    notifyListeners();
  }

  /// Update class colors (typically called after parsing)
  void updateClassColors(Map<String, ColorSet> colors) {
    _classColors = colors;
    notifyListeners();
  }

  /// Update color for a specific subject
  void updateClassColor(String subject, ColorSet color) {
    _classColors[subject] = color;
    notifyListeners();
  }

  /// Set custom time range
  void setTimeRange(Time start, Time end) {
    _customStartTime = start;
    _customEndTime = end;
    notifyListeners();
  }

  /// Clear custom time range (use auto-detect)
  void clearTimeRange() {
    _customStartTime = null;
    _customEndTime = null;
    notifyListeners();
  }

  /// Update table border color
  void updateTableBorderColor(Color color) {
    _tableBorderColor = color;
    notifyListeners();
  }

  /// Update table background color
  void updateTableBackgroundColor(Color color) {
    _tableBackgroundColor = color;
    notifyListeners();
  }

  /// Update corner radius
  void updateCornerRadius(double radius) {
    _cornerRadius = radius;
    notifyListeners();
  }

  /// Set background image
  void setBackgroundImage(String? path) {
    _backgroundImagePath = path;
    notifyListeners();
  }

  /// Clear background image
  void clearBackgroundImage() {
    _backgroundImagePath = null;
    notifyListeners();
  }

  /// Update weekday color
  void updateWeekdayColor(Weekday weekday, Color color) {
    _weekdayColors[weekday] = color;
    notifyListeners();
  }

  /// Reset all table customizations to defaults
  void resetTableCustomizations() {
    _tableBorderColor = Colors.grey;
    _tableBackgroundColor = Colors.white;
    _cornerRadius = 8.0;
    _backgroundImagePath = null;
    _weekdayColors = {
      Weekday.monday: Colors.blue.shade100,
      Weekday.tuesday: Colors.green.shade100,
      Weekday.wednesday: Colors.orange.shade100,
      Weekday.thursday: Colors.purple.shade100,
      Weekday.friday: Colors.red.shade100,
      Weekday.saturday: Colors.teal.shade100,
      Weekday.sunday: Colors.pink.shade100,
    };
    notifyListeners();
  }

  /// Apply a theme preset
  void applyThemePreset(ThemePreset preset) {
    _isDarkMode = preset.isDarkMode;

    // Convert ColorData to ColorSet
    final colorSets = <String, ColorSet>{};
    for (final entry in preset.classColors.entries) {
      final colorData = entry.value;
      colorSets[entry.key] = ColorSet(
        primary: colorData,
        light: ColorService.assignColors([]).values.first.light, // Placeholder
        dark: ColorService.assignColors([]).values.first.dark, // Placeholder
        text: ColorService.assignColors([]).values.first.text, // Placeholder
      );
    }

    _classColors = colorSets;
    notifyListeners();
  }
}
