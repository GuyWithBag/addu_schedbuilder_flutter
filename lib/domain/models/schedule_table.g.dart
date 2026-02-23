// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleTable _$ScheduleTableFromJson(Map<String, dynamic> json) =>
    ScheduleTable(
      rows: (json['rows'] as List<dynamic>)
          .map((e) => ScheduleRow.fromJson(e as Map<String, dynamic>))
          .toList(),
      peWeekdays:
          (json['peWeekdays'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$WeekdayEnumMap, e))
              .toSet() ??
          const {},
      weekdayConfig:
          (json['weekdayConfig'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry($enumDecode(_$WeekdayEnumMap, k), e as bool),
          ) ??
          const {},
    );

Map<String, dynamic> _$ScheduleTableToJson(
  ScheduleTable instance,
) => <String, dynamic>{
  'rows': instance.rows,
  'peWeekdays': instance.peWeekdays.map((e) => _$WeekdayEnumMap[e]!).toList(),
  'weekdayConfig': instance.weekdayConfig.map(
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
