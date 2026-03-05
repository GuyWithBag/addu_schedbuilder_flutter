// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_preset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColorData _$ColorDataFromJson(Map<String, dynamic> json) => ColorData(
  red: (json['red'] as num).toInt(),
  green: (json['green'] as num).toInt(),
  blue: (json['blue'] as num).toInt(),
  alpha: (json['alpha'] as num?)?.toInt() ?? 255,
);

Map<String, dynamic> _$ColorDataToJson(ColorData instance) => <String, dynamic>{
  'red': instance.red,
  'green': instance.green,
  'blue': instance.blue,
  'alpha': instance.alpha,
};

ThemePreset _$ThemePresetFromJson(Map<String, dynamic> json) => ThemePreset(
  id: json['id'] as String,
  name: json['name'] as String,
  classColors:
      (json['classColors'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, ColorData.fromJson(e as Map<String, dynamic>)),
      ) ??
      const {},
  isDarkMode: json['isDarkMode'] as bool? ?? false,
);

Map<String, dynamic> _$ThemePresetToJson(ThemePreset instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'classColors': instance.classColors,
      'isDarkMode': instance.isDarkMode,
    };
