// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassData _$ClassDataFromJson(Map<String, dynamic> json) => ClassData(
  code: json['code'] as String,
  subject: json['subject'] as String,
  title: json['title'] as String,
  schedule: (json['schedule'] as List<dynamic>)
      .map((e) => ClassPeriod.fromJson(e as Map<String, dynamic>))
      .toList(),
  teacher: json['teacher'] == null
      ? null
      : Teacher.fromJson(json['teacher'] as Map<String, dynamic>),
  units: (json['units'] as num?)?.toInt() ?? 3,
);

Map<String, dynamic> _$ClassDataToJson(ClassData instance) => <String, dynamic>{
  'code': instance.code,
  'subject': instance.subject,
  'title': instance.title,
  'schedule': instance.schedule,
  'teacher': instance.teacher,
  'units': instance.units,
};
