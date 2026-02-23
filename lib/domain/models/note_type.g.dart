// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteTypeAdapter extends TypeAdapter<NoteType> {
  @override
  final typeId = 11;

  @override
  NoteType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NoteType.general;
      case 1:
        return NoteType.homework;
      case 2:
        return NoteType.exam;
      default:
        return NoteType.general;
    }
  }

  @override
  void write(BinaryWriter writer, NoteType obj) {
    switch (obj) {
      case NoteType.general:
        writer.writeByte(0);
      case NoteType.homework:
        writer.writeByte(1);
      case NoteType.exam:
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
