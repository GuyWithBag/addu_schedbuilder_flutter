// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationConfigAdapter extends TypeAdapter<NotificationConfig> {
  @override
  final typeId = 13;

  @override
  NotificationConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationConfig(
      enabled: fields[0] == null ? false : fields[0] as bool,
      minutesBefore: fields[1] == null ? 10 : (fields[1] as num).toInt(),
      activeDays: fields[2] == null ? {} : (fields[2] as Set).cast<Weekday>(),
    );
  }

  @override
  void write(BinaryWriter writer, NotificationConfig obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.enabled)
      ..writeByte(1)
      ..write(obj.minutesBefore)
      ..writeByte(2)
      ..write(obj.activeDays);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationConfigImpl _$$NotificationConfigImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationConfigImpl(
  enabled: json['enabled'] as bool? ?? false,
  minutesBefore: (json['minutesBefore'] as num?)?.toInt() ?? 10,
  activeDays:
      (json['activeDays'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$WeekdayEnumMap, e))
          .toSet() ??
      const {},
);

Map<String, dynamic> _$$NotificationConfigImplToJson(
  _$NotificationConfigImpl instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'minutesBefore': instance.minutesBefore,
  'activeDays': instance.activeDays.map((e) => _$WeekdayEnumMap[e]!).toList(),
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
