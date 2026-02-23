import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

part 'theme_preset.freezed.dart';
part 'theme_preset.g.dart';

/// Simple color storage (RGB values)
@freezed
@HiveType(typeId: 9)
class ColorData with _$ColorData {
  const factory ColorData({
    @HiveField(0) required int red,
    @HiveField(1) required int green,
    @HiveField(2) required int blue,
    @HiveField(3) @Default(255) int alpha,
  }) = _ColorData;

  factory ColorData.fromJson(Map<String, dynamic> json) =>
      _$ColorDataFromJson(json);
}

/// Theme preset for a schedule
@freezed
@HiveType(typeId: 10)
class ThemePreset with _$ThemePreset {
  const ThemePreset._();

  const factory ThemePreset({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) @Default({}) Map<String, ColorData> classColors,
    @HiveField(3) @Default(false) bool isDarkMode,
  }) = _ThemePreset;

  factory ThemePreset.fromJson(Map<String, dynamic> json) =>
      _$ThemePresetFromJson(json);
}
