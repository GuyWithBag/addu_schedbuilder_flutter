// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationConfig _$NotificationConfigFromJson(Map<String, dynamic> json) =>
    NotificationConfig(
      enabled: json['enabled'] as bool? ?? false,
      minutesBefore: (json['minutesBefore'] as num?)?.toInt() ?? 10,
      activeDays:
          (json['activeDays'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$WeekdayEnumMap, e))
              .toSet() ??
          const {},
    );

Map<String, dynamic> _$NotificationConfigToJson(
  NotificationConfig instance,
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
