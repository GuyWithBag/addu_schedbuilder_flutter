// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_schedule.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedScheduleAdapter extends TypeAdapter<SavedSchedule> {
  @override
  final typeId = 8;

  @override
  SavedSchedule read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedSchedule(
      id: fields[0] as String,
      name: fields[1] as String,
      createdAt: fields[2] as DateTime,
      table: fields[3] as ScheduleTable,
      semester: fields[4] as String?,
      themePreset: fields[5] as ThemePreset?,
    );
  }

  @override
  void write(BinaryWriter writer, SavedSchedule obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.table)
      ..writeByte(4)
      ..write(obj.semester)
      ..writeByte(5)
      ..write(obj.themePreset);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedScheduleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SavedScheduleImpl _$$SavedScheduleImplFromJson(Map<String, dynamic> json) =>
    _$SavedScheduleImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      table: ScheduleTable.fromJson(json['table'] as Map<String, dynamic>),
      semester: json['semester'] as String?,
      themePreset: json['themePreset'] == null
          ? null
          : ThemePreset.fromJson(json['themePreset'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SavedScheduleImplToJson(_$SavedScheduleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt.toIso8601String(),
      'table': instance.table,
      'semester': instance.semester,
      'themePreset': instance.themePreset,
    };
