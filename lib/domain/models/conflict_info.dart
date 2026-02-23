import 'package:freezed_annotation/freezed_annotation.dart';
import 'class_data.dart';
import 'time.dart';
import 'weekday.dart';

part 'conflict_info.freezed.dart';
part 'conflict_info.g.dart';

/// Represents a scheduling conflict (overlapping classes)
/// Note: Not persisted to Hive - computed on-demand
@freezed
class ConflictInfo with _$ConflictInfo {
  const ConflictInfo._();

  const factory ConflictInfo({
    required List<ClassData> conflictingClasses,
    required Time startTime,
    required Time endTime,
    required Weekday weekday,
  }) = _ConflictInfo;

  factory ConflictInfo.fromJson(Map<String, dynamic> json) =>
      _$ConflictInfoFromJson(json);

  /// Get duration of conflict in minutes
  int get duration => startTime.durationUntil(endTime);

  /// Get class codes involved in conflict
  List<String> get classCodes => conflictingClasses.map((c) => c.code).toList();
}
