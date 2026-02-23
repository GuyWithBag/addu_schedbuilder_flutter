import 'package:flutter/foundation.dart';
import '../../domain/models/theme_preset.dart';
import '../../domain/models/time.dart';
import '../../domain/services/color_service.dart';

/// Provider for managing display configuration (colors, dark mode, time format)
class DisplayConfigProvider extends ChangeNotifier {
  Map<String, ColorSet> _classColors = {};
  bool _isDarkMode = false;
  bool _is24HourFormat = false;
  Time? _customStartTime;
  Time? _customEndTime;

  Map<String, ColorSet> get classColors => _classColors;
  bool get isDarkMode => _isDarkMode;
  bool get is24HourFormat => _is24HourFormat;
  Time? get customStartTime => _customStartTime;
  Time? get customEndTime => _customEndTime;

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
