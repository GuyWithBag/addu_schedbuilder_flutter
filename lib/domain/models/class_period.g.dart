// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_period.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClassPeriodAdapter extends TypeAdapter<ClassPeriod> {
  @override
  final typeId = 2;

  @override
  ClassPeriod read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClassPeriod(
      start: fields[0] as Time,
      end: fields[1] as Time,
      room: fields[2] as String,
      weekdays: (fields[3] as List).cast<Weekday>(),
    );
  }

  @override
  void write(BinaryWriter writer, ClassPeriod obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.start)
      ..writeByte(1)
      ..write(obj.end)
      ..writeByte(2)
      ..write(obj.room)
      ..writeByte(3)
      ..write(obj.weekdays);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassPeriodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClassPeriodImpl _$$ClassPeriodImplFromJson(Map<String, dynamic> json) =>
    _$ClassPeriodImpl(
      start: Time.fromJson(json['start'] as Map<String, dynamic>),
      end: Time.fromJson(json['end'] as Map<String, dynamic>),
      room: json['room'] as String,
      weekdays: (json['weekdays'] as List<dynamic>)
          .map((e) => $enumDecode(_$WeekdayEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$$ClassPeriodImplToJson(_$ClassPeriodImpl instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
      'room': instance.room,
      'weekdays': instance.weekdays.map((e) => _$WeekdayEnumMap[e]!).toList(),
    };

const _$WeekdayEnumMap = {
  Weekday.sunday: 'sunday',
  Weekday.monday: 'monday',
  Weekday.tuesday: 'tuesday',
  Weekday.wednesday: 'wednesday',
  Weekday.thursday: 'thursday',
  Weekday.friday: 'friday',
  Weekday.saturday: 'saturday',
};
