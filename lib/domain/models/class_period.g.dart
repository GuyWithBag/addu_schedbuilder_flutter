// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_period.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassPeriod _$ClassPeriodFromJson(Map<String, dynamic> json) => ClassPeriod(
  start: Time.fromJson(json['start'] as Map<String, dynamic>),
  end: Time.fromJson(json['end'] as Map<String, dynamic>),
  room: json['room'] as String,
  weekdays: (json['weekdays'] as List<dynamic>)
      .map((e) => $enumDecode(_$WeekdayEnumMap, e))
      .toList(),
);

Map<String, dynamic> _$ClassPeriodToJson(ClassPeriod instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
      'room': instance.room,
      'weekdays': instance.weekdays.map((e) => _$WeekdayEnumMap[e]!).toList(),
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
