import '../models/class_data.dart';
import '../models/theme_preset.dart';
import '../models/weekday.dart';

/// Color set for a subject
class ColorSet {
  final ColorData primary;
  final ColorData light;
  final ColorData dark;
  final ColorData text;

  const ColorSet({
    required this.primary,
    required this.light,
    required this.dark,
    required this.text,
  });
}

/// Service for assigning colors to subjects
class ColorService {
  ColorService._();

  /// 10-color Material Design palette
  static const _colorPalette = [
    // Red
    ColorData(red: 244, green: 67, blue: 54),
    // Pink
    ColorData(red: 233, green: 30, blue: 99),
    // Purple
    ColorData(red: 156, green: 39, blue: 176),
    // Deep Purple
    ColorData(red: 103, green: 58, blue: 183),
    // Indigo
    ColorData(red: 63, green: 81, blue: 181),
    // Blue
    ColorData(red: 33, green: 150, blue: 243),
    // Light Blue
    ColorData(red: 3, green: 169, blue: 244),
    // Cyan
    ColorData(red: 0, green: 188, blue: 212),
    // Teal
    ColorData(red: 0, green: 150, blue: 136),
    // Green
    ColorData(red: 76, green: 175, blue: 80),
  ];

  /// Assign colors to a list of classes
  /// Uses a rotating palette to ensure distinct colors
  static Map<String, ColorSet> assignColors(List<ClassData> classes) {
    final colorMap = <String, ColorSet>{};
    final uniqueSubjects = classes.map((c) => c.subject).toSet().toList();

    for (var i = 0; i < uniqueSubjects.length; i++) {
      final subject = uniqueSubjects[i];
      final colorIndex = i % _colorPalette.length;
      final primaryColor = _colorPalette[colorIndex];

      colorMap[subject] = ColorSet(
        primary: primaryColor,
        light: _lighten(primaryColor),
        dark: _darken(primaryColor),
        text: _getTextColor(primaryColor),
      );
    }

    return colorMap;
  }

  /// Get color for a weekday header
  static ColorData getWeekdayColor(Weekday weekday) {
    switch (weekday) {
      case Weekday.monday:
        return const ColorData(red: 255, green: 152, blue: 0); // Orange
      case Weekday.tuesday:
        return const ColorData(red: 156, green: 39, blue: 176); // Purple
      case Weekday.wednesday:
        return const ColorData(red: 33, green: 150, blue: 243); // Blue
      case Weekday.thursday:
        return const ColorData(red: 76, green: 175, blue: 80); // Green
      case Weekday.friday:
        return const ColorData(red: 244, green: 67, blue: 54); // Red
      case Weekday.saturday:
        return const ColorData(red: 103, green: 58, blue: 183); // Deep Purple
      case Weekday.sunday:
        return const ColorData(red: 233, green: 30, blue: 99); // Pink
    }
  }

  /// Lighten a color by 20%
  static ColorData _lighten(ColorData color) {
    return ColorData(
      red: (color.red + (255 - color.red) * 0.2).round().clamp(0, 255),
      green: (color.green + (255 - color.green) * 0.2).round().clamp(0, 255),
      blue: (color.blue + (255 - color.blue) * 0.2).round().clamp(0, 255),
      alpha: color.alpha,
    );
  }

  /// Darken a color by 20%
  static ColorData _darken(ColorData color) {
    return ColorData(
      red: (color.red * 0.8).round().clamp(0, 255),
      green: (color.green * 0.8).round().clamp(0, 255),
      blue: (color.blue * 0.8).round().clamp(0, 255),
      alpha: color.alpha,
    );
  }

  /// Get appropriate text color (white or black) based on background luminance
  static ColorData _getTextColor(ColorData backgroundColor) {
    // Calculate relative luminance
    final r = backgroundColor.red / 255;
    final g = backgroundColor.green / 255;
    final b = backgroundColor.blue / 255;

    final luminance = 0.299 * r + 0.587 * g + 0.114 * b;

    // Use white text for dark backgrounds, black for light backgrounds
    return luminance > 0.5
        ? const ColorData(red: 0, green: 0, blue: 0) // Black
        : const ColorData(red: 255, green: 255, blue: 255); // White
  }
}
