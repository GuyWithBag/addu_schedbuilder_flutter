// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_row.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScheduleRowAdapter extends TypeAdapter<ScheduleRow> {
  @override
  final typeId = 6;

  @override
  ScheduleRow read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduleRow(
      time: fields[0] as Time,
      duration: (fields[1] as num).toInt(),
      columns: (fields[2] as List).cast<TimeSlot?>(),
    );
  }

  @override
  void write(BinaryWriter writer, ScheduleRow obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.duration)
      ..writeByte(2)
      ..write(obj.columns);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleRowAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduleRowImpl _$$ScheduleRowImplFromJson(Map<String, dynamic> json) =>
    _$ScheduleRowImpl(
      time: Time.fromJson(json['time'] as Map<String, dynamic>),
      duration: (json['duration'] as num).toInt(),
      columns: (json['columns'] as List<dynamic>)
          .map(
            (e) =>
                e == null ? null : TimeSlot.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$$ScheduleRowImplToJson(_$ScheduleRowImpl instance) =>
    <String, dynamic>{
      'time': instance.time,
      'duration': instance.duration,
      'columns': instance.columns,
    };
