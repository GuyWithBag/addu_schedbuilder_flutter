import 'package:json_annotation/json_annotation.dart';

part 'time.g.dart';

@JsonSerializable()
class Time {
  final int hour;
  final int minute;

  const Time({required this.hour, required this.minute});

  /// JSON serialization
  factory Time.fromJson(Map<String, dynamic> json) => _$TimeFromJson(json);
  Map<String, dynamic> toJson() => _$TimeToJson(this);

  /// Convert time to total minutes since midnight
  int toMinutes() => hour * 60 + minute;

  /// Create Time from total minutes since midnight
  factory Time.fromMinutes(int totalMinutes) {
    return Time(hour: totalMinutes ~/ 60, minute: totalMinutes % 60);
  }

  /// Format time as string
  /// @param is24Hour: true for 24-hour format (14:30), false for 12-hour format (2:30 PM)
  String format(bool is24Hour) {
    if (is24Hour) {
      return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    } else {
      final period = hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
      return '$displayHour:${minute.toString().padLeft(2, '0')} $period';
    }
  }

  /// Check if this time is before another time
  bool isBefore(Time other) => toMinutes() < other.toMinutes();

  /// Check if this time is after another time
  bool isAfter(Time other) => toMinutes() > other.toMinutes();

  /// Calculate duration in minutes between two times
  int durationUntil(Time other) => other.toMinutes() - toMinutes();

  /// CopyWith method for immutability
  Time copyWith({int? hour, int? minute}) {
    return Time(hour: hour ?? this.hour, minute: minute ?? this.minute);
  }

  /// Equality and hashCode
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Time &&
          runtimeType == other.runtimeType &&
          hour == other.hour &&
          minute == other.minute;

  @override
  int get hashCode => hour.hashCode ^ minute.hashCode;

  @override
  String toString() => 'Time(hour: $hour, minute: $minute)';
}
