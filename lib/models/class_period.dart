import 'package:json_annotation/json_annotation.dart';
import 'time.dart';
import 'weekday.dart';

part 'class_period.g.dart';

@JsonSerializable()
class ClassPeriod {
  final Time start;
  final Time end;
  final String room;
  final List<Weekday> weekdays;

  const ClassPeriod({
    required this.start,
    required this.end,
    required this.room,
    required this.weekdays,
  });

  /// JSON serialization
  factory ClassPeriod.fromJson(Map<String, dynamic> json) =>
      _$ClassPeriodFromJson(json);
  Map<String, dynamic> toJson() => _$ClassPeriodToJson(this);

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

  /// CopyWith method for immutability
  ClassPeriod copyWith({
    Time? start,
    Time? end,
    String? room,
    List<Weekday>? weekdays,
  }) {
    return ClassPeriod(
      start: start ?? this.start,
      end: end ?? this.end,
      room: room ?? this.room,
      weekdays: weekdays ?? this.weekdays,
    );
  }

  /// Equality and hashCode
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassPeriod &&
          runtimeType == other.runtimeType &&
          start == other.start &&
          end == other.end &&
          room == other.room &&
          _listEquals(weekdays, other.weekdays);

  @override
  int get hashCode =>
      start.hashCode ^
      end.hashCode ^
      room.hashCode ^
      weekdays.fold(0, (prev, element) => prev ^ element.hashCode);

  @override
  String toString() =>
      'ClassPeriod(start: $start, end: $end, room: $room, weekdays: $weekdays)';

  static bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
