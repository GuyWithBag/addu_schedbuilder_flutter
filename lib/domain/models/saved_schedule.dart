import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'schedule_table.dart';
import 'theme_preset.dart';

part 'saved_schedule.freezed.dart';
part 'saved_schedule.g.dart';

@freezed
@HiveType(typeId: 8)
class SavedSchedule with _$SavedSchedule {
  const SavedSchedule._();

  const factory SavedSchedule({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required DateTime createdAt,
    @HiveField(3) required ScheduleTable table,
    @HiveField(4) String? semester,
    @HiveField(5) ThemePreset? themePreset,
  }) = _SavedSchedule;

  factory SavedSchedule.fromJson(Map<String, dynamic> json) =>
      _$SavedScheduleFromJson(json);

  /// Get total number of classes in this schedule
  int get classCount => table.getAllClasses().length;

  /// Get total hours per week
  double get totalHoursPerWeek {
    return table.getAllClasses().fold(
      0.0,
      (sum, classData) => sum + classData.hoursPerWeek,
    );
  }
}
