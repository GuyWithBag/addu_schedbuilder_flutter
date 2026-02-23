// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_note.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClassNoteAdapter extends TypeAdapter<ClassNote> {
  @override
  final typeId = 12;

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

class NoteTypeAdapter extends TypeAdapter<NoteType> {
  @override
  final typeId = 11;

  @override
  NoteType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NoteType.homework;
      case 1:
        return NoteType.exam;
      case 2:
        return NoteType.general;
      default:
        return NoteType.homework;
    }
  }

  @override
  void write(BinaryWriter writer, NoteType obj) {
    switch (obj) {
      case NoteType.homework:
        writer.writeByte(0);
      case NoteType.exam:
        writer.writeByte(1);
      case NoteType.general:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteTypeAdapter &&
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
  NoteType.homework: 'homework',
  NoteType.exam: 'exam',
  NoteType.general: 'general',
};
