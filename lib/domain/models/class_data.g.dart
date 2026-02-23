// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClassDataAdapter extends TypeAdapter<ClassData> {
  @override
  final typeId = 4;

  @override
  ClassData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClassData(
      code: fields[0] as String,
      subject: fields[1] as String,
      title: fields[2] as String,
      schedule: (fields[3] as List).cast<ClassPeriod>(),
      teacher: fields[4] as Teacher?,
      units: fields[5] == null ? 3 : (fields[5] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, ClassData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.subject)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.schedule)
      ..writeByte(4)
      ..write(obj.teacher)
      ..writeByte(5)
      ..write(obj.units);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClassDataImpl _$$ClassDataImplFromJson(Map<String, dynamic> json) =>
    _$ClassDataImpl(
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

Map<String, dynamic> _$$ClassDataImplToJson(_$ClassDataImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'subject': instance.subject,
      'title': instance.title,
      'schedule': instance.schedule,
      'teacher': instance.teacher,
      'units': instance.units,
    };
