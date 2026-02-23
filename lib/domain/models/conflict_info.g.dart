// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conflict_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConflictInfoImpl _$$ConflictInfoImplFromJson(Map<String, dynamic> json) =>
    _$ConflictInfoImpl(
      conflictingClasses: (json['conflictingClasses'] as List<dynamic>)
          .map((e) => ClassData.fromJson(e as Map<String, dynamic>))
          .toList(),
      startTime: Time.fromJson(json['startTime'] as Map<String, dynamic>),
      endTime: Time.fromJson(json['endTime'] as Map<String, dynamic>),
      weekday: $enumDecode(_$WeekdayEnumMap, json['weekday']),
    );

Map<String, dynamic> _$$ConflictInfoImplToJson(_$ConflictInfoImpl instance) =>
    <String, dynamic>{
      'conflictingClasses': instance.conflictingClasses,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'weekday': _$WeekdayEnumMap[instance.weekday]!,
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
