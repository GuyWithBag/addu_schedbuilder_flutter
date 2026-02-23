import 'package:json_annotation/json_annotation.dart';

part 'theme_preset.g.dart';

/// Simple color storage (RGB values)
@JsonSerializable()
class ColorData {
  final int red;
  final int green;
  final int blue;
  final int alpha;

  const ColorData({
    required this.red,
    required this.green,
    required this.blue,
    this.alpha = 255,
  });

  /// JSON serialization
  factory ColorData.fromJson(Map<String, dynamic> json) =>
      _$ColorDataFromJson(json);
  Map<String, dynamic> toJson() => _$ColorDataToJson(this);

  /// CopyWith method for immutability
  ColorData copyWith({int? red, int? green, int? blue, int? alpha}) {
    return ColorData(
      red: red ?? this.red,
      green: green ?? this.green,
      blue: blue ?? this.blue,
      alpha: alpha ?? this.alpha,
    );
  }

  /// Equality and hashCode
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColorData &&
          runtimeType == other.runtimeType &&
          red == other.red &&
          green == other.green &&
          blue == other.blue &&
          alpha == other.alpha;

  @override
  int get hashCode =>
      red.hashCode ^ green.hashCode ^ blue.hashCode ^ alpha.hashCode;

  @override
  String toString() =>
      'ColorData(red: $red, green: $green, blue: $blue, alpha: $alpha)';
}

/// Theme preset for a schedule
@JsonSerializable()
class ThemePreset {
  final String id;
  final String name;
  final Map<String, ColorData> classColors;
  final bool isDarkMode;

  const ThemePreset({
    required this.id,
    required this.name,
    this.classColors = const {},
    this.isDarkMode = false,
  });

  /// JSON serialization
  factory ThemePreset.fromJson(Map<String, dynamic> json) =>
      _$ThemePresetFromJson(json);
  Map<String, dynamic> toJson() => _$ThemePresetToJson(this);

  /// CopyWith method for immutability
  ThemePreset copyWith({
    String? id,
    String? name,
    Map<String, ColorData>? classColors,
    bool? isDarkMode,
  }) {
    return ThemePreset(
      id: id ?? this.id,
      name: name ?? this.name,
      classColors: classColors ?? this.classColors,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  /// Equality and hashCode
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemePreset &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          _mapEquals(classColors, other.classColors) &&
          isDarkMode == other.isDarkMode;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      classColors.entries.fold(
        0,
        (prev, entry) => prev ^ entry.key.hashCode ^ entry.value.hashCode,
      ) ^
      isDarkMode.hashCode;

  @override
  String toString() =>
      'ThemePreset(id: $id, name: $name, classColors: $classColors, isDarkMode: $isDarkMode)';

  static bool _mapEquals<K, V>(Map<K, V>? a, Map<K, V>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key) || a[key] != b[key]) return false;
    }
    return true;
  }
}
