import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'class_data.dart';
import 'schedule_row.dart';
import 'time_slot.dart';
import 'weekday.dart';

part 'schedule_table.freezed.dart';
part 'schedule_table.g.dart';

@freezed
@HiveType(typeId: 7)
class ScheduleTable with _$ScheduleTable {
  const ScheduleTable._();

  const factory ScheduleTable({
    @HiveField(0) required List<ScheduleRow> rows,
    @HiveField(1) @Default({}) Set<Weekday> peWeekdays,
    @HiveField(2) @Default({}) Map<Weekday, bool> weekdayConfig,
  }) = _ScheduleTable;

  factory ScheduleTable.fromJson(Map<String, dynamic> json) =>
      _$ScheduleTableFromJson(json);

  /// Get all classes in the schedule
  List<ClassData> getAllClasses() {
    final classes = <ClassData>[];
    final seen = <String>{};

    for (final row in rows) {
      for (final slot in row.columns) {
        if (slot is ClassSlot) {
          final code = slot.classData.code;
          if (!seen.contains(code)) {
            seen.add(code);
            classes.add(slot.classData);
          }
        }
      }
    }

    return classes;
  }

  /// Get all classes for a specific weekday
  List<ClassData> getClassesForWeekday(Weekday weekday) {
    final classes = <ClassData>[];
    final seen = <String>{};
    final weekdayIndex = weekday.dayIndex;

    for (final row in rows) {
      if (weekdayIndex < row.columns.length) {
        final slot = row.columns[weekdayIndex];
        if (slot is ClassSlot) {
          final code = slot.classData.code;
          if (!seen.contains(code)) {
            seen.add(code);
            classes.add(slot.classData);
          }
        }
      }
    }

    return classes;
  }

  /// Check if schedule is empty
  bool get isEmpty => rows.isEmpty || !rows.any((row) => row.hasClasses);
}
