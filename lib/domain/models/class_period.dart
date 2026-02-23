import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'time.dart';
import 'weekday.dart';

part 'class_period.freezed.dart';
part 'class_period.g.dart';

@freezed
@HiveType(typeId: 2)
class ClassPeriod with _$ClassPeriod {
  const ClassPeriod._();

  const factory ClassPeriod({
    @HiveField(0) required Time start,
    @HiveField(1) required Time end,
    @HiveField(2) required String room,
    @HiveField(3) required List<Weekday> weekdays,
  }) = _ClassPeriod;

  factory ClassPeriod.fromJson(Map<String, dynamic> json) =>
      _$ClassPeriodFromJson(json);

  /// Calculate duration of this period in minutes
  int get duration => start.durationUntil(end);

  /// Check if this period overlaps with another period on a given weekday
  bool overlapsWith(ClassPeriod other, Weekday weekday) {
    // Check if both periods occur on this weekday
    if (!weekdays.contains(weekday) || !other.weekdays.contains(weekday)) {
      return false;
    }

    // Check if time ranges overlap
    // Overlap occurs if: start1 < end2 AND start2 < end1
    return start.toMinutes() < other.end.toMinutes() &&
        other.start.toMinutes() < end.toMinutes();
  }
}
