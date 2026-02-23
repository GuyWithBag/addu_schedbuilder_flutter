// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScheduleTableAdapter extends TypeAdapter<ScheduleTable> {
  @override
  final typeId = 7;

  @override
  ScheduleTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduleTable(
      rows: (fields[0] as List).cast<ScheduleRow>(),
      peWeekdays: fields[1] == null ? {} : (fields[1] as Set).cast<Weekday>(),
      weekdayConfig: fields[2] == null
          ? {}
          : (fields[2] as Map).cast<Weekday, bool>(),
    );
  }

  @override
  void write(BinaryWriter writer, ScheduleTable obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.rows)
      ..writeByte(1)
      ..write(obj.peWeekdays)
      ..writeByte(2)
      ..write(obj.weekdayConfig);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduleTableImpl _$$ScheduleTableImplFromJson(Map<String, dynamic> json) =>
    _$ScheduleTableImpl(
      rows: (json['rows'] as List<dynamic>)
          .map((e) => ScheduleRow.fromJson(e as Map<String, dynamic>))
          .toList(),
      peWeekdays:
          (json['peWeekdays'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$WeekdayEnumMap, e))
              .toSet() ??
          const {},
      weekdayConfig:
          (json['weekdayConfig'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry($enumDecode(_$WeekdayEnumMap, k), e as bool),
          ) ??
          const {},
    );

Map<String, dynamic> _$$ScheduleTableImplToJson(
  _$ScheduleTableImpl instance,
) => <String, dynamic>{
  'rows': instance.rows,
  'peWeekdays': instance.peWeekdays.map((e) => _$WeekdayEnumMap[e]!).toList(),
  'weekdayConfig': instance.weekdayConfig.map(
    (k, e) => MapEntry(_$WeekdayEnumMap[k]!, e),
  ),
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
