import 'package:json_annotation/json_annotation.dart';
import 'time.dart';
import 'time_slot.dart';

part 'schedule_row.g.dart';

@JsonSerializable()
class ScheduleRow {
  final Time time;
  final int duration;
  final List<TimeSlot?> columns;

  const ScheduleRow({
    required this.time,
    required this.duration,
    required this.columns,
  });

  /// JSON serialization
  factory ScheduleRow.fromJson(Map<String, dynamic> json) =>
      _$ScheduleRowFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleRowToJson(this);

  /// Check if this row has any classes
  bool get hasClasses => columns.any((slot) => slot is ClassSlot);

  /// CopyWith method for immutability
  ScheduleRow copyWith({Time? time, int? duration, List<TimeSlot?>? columns}) {
    return ScheduleRow(
      time: time ?? this.time,
      duration: duration ?? this.duration,
      columns: columns ?? this.columns,
    );
  }

  /// Equality and hashCode
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleRow &&
          runtimeType == other.runtimeType &&
          time == other.time &&
          duration == other.duration &&
          _listEquals(columns, other.columns);

  @override
  int get hashCode =>
      time.hashCode ^
      duration.hashCode ^
      columns.fold(0, (prev, element) => prev ^ (element?.hashCode ?? 0));

  @override
  String toString() =>
      'ScheduleRow(time: $time, duration: $duration, columns: $columns)';

  static bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
