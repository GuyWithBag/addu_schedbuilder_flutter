// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_slot.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClassSlotAdapter extends TypeAdapter<_$ClassSlotImpl> {
  @override
  final typeId = 5;

  @override
  _$ClassSlotImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$ClassSlotImpl(
      classData: fields[0] as ClassData,
      rowspan: fields[1] == null ? 1 : (fields[1] as num).toInt(),
      colspan: fields[2] == null ? 1 : (fields[2] as num).toInt(),
      duration: (fields[3] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, _$ClassSlotImpl obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.classData)
      ..writeByte(1)
      ..write(obj.rowspan)
      ..writeByte(2)
      ..write(obj.colspan)
      ..writeByte(3)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassSlotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BarSlotAdapter extends TypeAdapter<_$BarSlotImpl> {
  @override
  final typeId = 14;

  @override
  _$BarSlotImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$BarSlotImpl(
      label: fields[0] as String,
      rowspan: fields[1] == null ? 1 : (fields[1] as num).toInt(),
      colspan: fields[2] == null ? 1 : (fields[2] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, _$BarSlotImpl obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.label)
      ..writeByte(1)
      ..write(obj.rowspan)
      ..writeByte(2)
      ..write(obj.colspan);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarSlotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EmptySlotAdapter extends TypeAdapter<_$EmptySlotImpl> {
  @override
  final typeId = 15;

  @override
  _$EmptySlotImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$EmptySlotImpl(
      rowspan: fields[0] == null ? 1 : (fields[0] as num).toInt(),
      colspan: fields[1] == null ? 1 : (fields[1] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, _$EmptySlotImpl obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.rowspan)
      ..writeByte(1)
      ..write(obj.colspan);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmptySlotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClassSlotImpl _$$ClassSlotImplFromJson(Map<String, dynamic> json) =>
    _$ClassSlotImpl(
      classData: ClassData.fromJson(json['classData'] as Map<String, dynamic>),
      rowspan: (json['rowspan'] as num?)?.toInt() ?? 1,
      colspan: (json['colspan'] as num?)?.toInt() ?? 1,
      duration: (json['duration'] as num).toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ClassSlotImplToJson(_$ClassSlotImpl instance) =>
    <String, dynamic>{
      'classData': instance.classData,
      'rowspan': instance.rowspan,
      'colspan': instance.colspan,
      'duration': instance.duration,
      'runtimeType': instance.$type,
    };

_$BarSlotImpl _$$BarSlotImplFromJson(Map<String, dynamic> json) =>
    _$BarSlotImpl(
      label: json['label'] as String,
      rowspan: (json['rowspan'] as num?)?.toInt() ?? 1,
      colspan: (json['colspan'] as num?)?.toInt() ?? 1,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$BarSlotImplToJson(_$BarSlotImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
      'rowspan': instance.rowspan,
      'colspan': instance.colspan,
      'runtimeType': instance.$type,
    };

_$EmptySlotImpl _$$EmptySlotImplFromJson(Map<String, dynamic> json) =>
    _$EmptySlotImpl(
      rowspan: (json['rowspan'] as num?)?.toInt() ?? 1,
      colspan: (json['colspan'] as num?)?.toInt() ?? 1,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$EmptySlotImplToJson(_$EmptySlotImpl instance) =>
    <String, dynamic>{
      'rowspan': instance.rowspan,
      'colspan': instance.colspan,
      'runtimeType': instance.$type,
    };
