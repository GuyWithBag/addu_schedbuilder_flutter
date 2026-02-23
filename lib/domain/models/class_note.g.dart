// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_note.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClassNoteAdapter extends TypeAdapter<ClassNote> {
  @override
  final typeId = 10;

  @override
  ClassNote read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClassNote(
      id: fields[0] as String,
      classCode: fields[1] as String,
      content: fields[2] as String,
      createdAt: fields[3] as DateTime,
      type: fields[4] == null ? NoteType.general : fields[4] as NoteType,
    );
  }

  @override
  void write(BinaryWriter writer, ClassNote obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.classCode)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassNoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClassNoteImpl _$$ClassNoteImplFromJson(Map<String, dynamic> json) =>
    _$ClassNoteImpl(
      id: json['id'] as String,
      classCode: json['classCode'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      type:
          $enumDecodeNullable(_$NoteTypeEnumMap, json['type']) ??
          NoteType.general,
    );

Map<String, dynamic> _$$ClassNoteImplToJson(_$ClassNoteImpl instance) =>
    <String, dynamic>{
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
