import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'weekday.dart';

part 'notification_config.freezed.dart';
part 'notification_config.g.dart';

@freezed
@HiveType(typeId: 13)
class NotificationConfig with _$NotificationConfig {
  const NotificationConfig._();

  const factory NotificationConfig({
    @HiveField(0) @Default(false) bool enabled,
    @HiveField(1) @Default(10) int minutesBefore,
    @HiveField(2) @Default({}) Set<Weekday> activeDays,
  }) = _NotificationConfig;

  factory NotificationConfig.fromJson(Map<String, dynamic> json) =>
      _$NotificationConfigFromJson(json);

  /// Check if notifications are enabled for a specific weekday
  bool isActiveOn(Weekday weekday) => enabled && activeDays.contains(weekday);
}
