import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'time.dart';
import 'time_slot.dart';

part 'schedule_row.freezed.dart';
part 'schedule_row.g.dart';

@freezed
@HiveType(typeId: 6)
class ScheduleRow with _$ScheduleRow {
  const ScheduleRow._();

  const factory ScheduleRow({
    @HiveField(0) required Time time,
    @HiveField(1) required int duration,
    @HiveField(2) required List<TimeSlot?> columns,
  }) = _ScheduleRow;

  factory ScheduleRow.fromJson(Map<String, dynamic> json) =>
      _$ScheduleRowFromJson(json);

  /// Check if this row has any classes
  bool get hasClasses => columns.any((slot) => slot is ClassSlot);
}
