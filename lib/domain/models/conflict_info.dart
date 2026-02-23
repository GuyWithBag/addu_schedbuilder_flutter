import 'package:json_annotation/json_annotation.dart';
import 'class_data.dart';
import 'time.dart';
import 'weekday.dart';

part 'conflict_info.g.dart';

/// Represents a scheduling conflict (overlapping classes)
/// Note: Not persisted to Hive - computed on-demand
@JsonSerializable()
class ConflictInfo {
  final List<ClassData> conflictingClasses;
  final Time startTime;
  final Time endTime;
  final Weekday weekday;

  const ConflictInfo({
    required this.conflictingClasses,
    required this.startTime,
    required this.endTime,
    required this.weekday,
  });

  /// JSON serialization
  factory ConflictInfo.fromJson(Map<String, dynamic> json) =>
      _$ConflictInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ConflictInfoToJson(this);

  /// Get duration of conflict in minutes
  int get duration => startTime.durationUntil(endTime);

  /// Get class codes involved in conflict
  List<String> get classCodes => conflictingClasses.map((c) => c.code).toList();

  /// CopyWith method for immutability
  ConflictInfo copyWith({
    List<ClassData>? conflictingClasses,
    Time? startTime,
    Time? endTime,
    Weekday? weekday,
  }) {
    return ConflictInfo(
      conflictingClasses: conflictingClasses ?? this.conflictingClasses,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      weekday: weekday ?? this.weekday,
    );
  }

  /// Equality and hashCode
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConflictInfo &&
          runtimeType == other.runtimeType &&
          _listEquals(conflictingClasses, other.conflictingClasses) &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          weekday == other.weekday;

  @override
  int get hashCode =>
      conflictingClasses.fold(0, (prev, element) => prev ^ element.hashCode) ^
      startTime.hashCode ^
      endTime.hashCode ^
      weekday.hashCode;

  @override
  String toString() =>
      'ConflictInfo(conflictingClasses: $conflictingClasses, startTime: $startTime, endTime: $endTime, weekday: $weekday)';

  static bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
