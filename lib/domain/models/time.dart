import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

part 'time.freezed.dart';
part 'time.g.dart';

@freezed
@HiveType(typeId: 0)
class Time with _$Time {
  const Time._();

  const factory Time({
    @HiveField(0) required int hour,
    @HiveField(1) required int minute,
  }) = _Time;

  factory Time.fromJson(Map<String, dynamic> json) => _$TimeFromJson(json);

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
}
