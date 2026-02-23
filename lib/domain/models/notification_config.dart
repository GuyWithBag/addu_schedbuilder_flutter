import 'package:json_annotation/json_annotation.dart';
import 'weekday.dart';

part 'notification_config.g.dart';

@JsonSerializable()
class NotificationConfig {
  final bool enabled;
  final int minutesBefore;
  final Set<Weekday> activeDays;

  const NotificationConfig({
    this.enabled = false,
    this.minutesBefore = 10,
    this.activeDays = const {},
  });

  /// JSON serialization
  factory NotificationConfig.fromJson(Map<String, dynamic> json) =>
      _$NotificationConfigFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationConfigToJson(this);

  /// Check if notifications are enabled for a specific weekday
  bool isActiveOn(Weekday weekday) => enabled && activeDays.contains(weekday);

  /// CopyWith method for immutability
  NotificationConfig copyWith({
    bool? enabled,
    int? minutesBefore,
    Set<Weekday>? activeDays,
  }) {
    return NotificationConfig(
      enabled: enabled ?? this.enabled,
      minutesBefore: minutesBefore ?? this.minutesBefore,
      activeDays: activeDays ?? this.activeDays,
    );
  }

  /// Equality and hashCode
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationConfig &&
          runtimeType == other.runtimeType &&
          enabled == other.enabled &&
          minutesBefore == other.minutesBefore &&
          _setEquals(activeDays, other.activeDays);

  @override
  int get hashCode =>
      enabled.hashCode ^
      minutesBefore.hashCode ^
      activeDays.fold(0, (prev, element) => prev ^ element.hashCode);

  @override
  String toString() =>
      'NotificationConfig(enabled: $enabled, minutesBefore: $minutesBefore, activeDays: $activeDays)';

  static bool _setEquals<T>(Set<T>? a, Set<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    return a.containsAll(b);
  }
}
