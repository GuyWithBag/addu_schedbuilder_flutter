// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavedSchedule _$SavedScheduleFromJson(Map<String, dynamic> json) =>
    SavedSchedule(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      table: ScheduleTable.fromJson(json['table'] as Map<String, dynamic>),
      semester: json['semester'] as String?,
      themePreset: json['themePreset'] == null
          ? null
          : ThemePreset.fromJson(json['themePreset'] as Map<String, dynamic>),
      inputText: json['inputText'] as String?,
    );

Map<String, dynamic> _$SavedScheduleToJson(SavedSchedule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt.toIso8601String(),
      'table': instance.table,
      'semester': instance.semester,
      'themePreset': instance.themePreset,
      'inputText': instance.inputText,
    };
