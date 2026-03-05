// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_theme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableTheme _$TableThemeFromJson(Map<String, dynamic> json) => TableTheme(
  id: json['id'] as String,
  name: json['name'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  tableBorderColor: ColorData.fromJson(
    json['tableBorderColor'] as Map<String, dynamic>,
  ),
  tableBackgroundColor: ColorData.fromJson(
    json['tableBackgroundColor'] as Map<String, dynamic>,
  ),
  cornerRadius: (json['cornerRadius'] as num).toDouble(),
  backgroundImagePath: json['backgroundImagePath'] as String?,
  weekdayColors: (json['weekdayColors'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(
      $enumDecode(_$WeekdayEnumMap, k),
      ColorData.fromJson(e as Map<String, dynamic>),
    ),
  ),
);

Map<String, dynamic> _$TableThemeToJson(TableTheme instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt.toIso8601String(),
      'tableBorderColor': instance.tableBorderColor,
      'tableBackgroundColor': instance.tableBackgroundColor,
      'cornerRadius': instance.cornerRadius,
      'backgroundImagePath': instance.backgroundImagePath,
      'weekdayColors': instance.weekdayColors.map(
        (k, e) => MapEntry(_$WeekdayEnumMap[k]!, e),
      ),
    };

const _$WeekdayEnumMap = {
  Weekday.sunday: 'sunday',
  Weekday.monday: 'monday',
  Weekday.tuesday: 'tuesday',
  Weekday.wednesday: 'wednesday',
  Weekday.thursday: 'thursday',
  Weekday.friday: 'friday',
  Weekday.saturday: 'saturday',
};
