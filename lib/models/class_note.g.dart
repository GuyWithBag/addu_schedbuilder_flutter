// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassNote _$ClassNoteFromJson(Map<String, dynamic> json) => ClassNote(
  id: json['id'] as String,
  classCode: json['classCode'] as String,
  content: json['content'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  type:
      $enumDecodeNullable(_$NoteTypeEnumMap, json['type']) ?? NoteType.general,
);

Map<String, dynamic> _$ClassNoteToJson(ClassNote instance) => <String, dynamic>{
  'id': instance.id,
  'classCode': instance.classCode,
  'content': instance.content,
  'createdAt': instance.createdAt.toIso8601String(),
  'type': _$NoteTypeEnumMap[instance.type]!,
};

const _$NoteTypeEnumMap = {
  NoteType.general: 'general',
  NoteType.homework: 'homework',
  NoteType.exam: 'exam',
};
