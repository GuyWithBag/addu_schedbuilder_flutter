// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teacher _$TeacherFromJson(Map<String, dynamic> json) => Teacher(
  familyName: json['familyName'] as String,
  givenName: json['givenName'] as String,
  emails: (json['emails'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$TeacherToJson(Teacher instance) => <String, dynamic>{
  'familyName': instance.familyName,
  'givenName': instance.givenName,
  'emails': instance.emails,
};
