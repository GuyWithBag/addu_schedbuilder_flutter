// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_row.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleRow _$ScheduleRowFromJson(Map<String, dynamic> json) => ScheduleRow(
  time: Time.fromJson(json['time'] as Map<String, dynamic>),
  duration: (json['duration'] as num).toInt(),
  columns: (json['columns'] as List<dynamic>)
      .map(
        (e) => e == null ? null : TimeSlot.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$ScheduleRowToJson(ScheduleRow instance) =>
    <String, dynamic>{
      'time': instance.time,
      'duration': instance.duration,
      'columns': instance.columns,
    };
