import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'class_period.dart';
import 'teacher.dart';

part 'class_data.freezed.dart';
part 'class_data.g.dart';

@freezed
@HiveType(typeId: 4)
class ClassData with _$ClassData {
  const ClassData._();

  const factory ClassData({
    @HiveField(0) required String code,
    @HiveField(1) required String subject,
    @HiveField(2) required String title,
    @HiveField(3) required List<ClassPeriod> schedule,
    @HiveField(4) Teacher? teacher,
    @HiveField(5) @Default(3) int units,
  }) = _ClassData;

  factory ClassData.fromJson(Map<String, dynamic> json) =>
      _$ClassDataFromJson(json);

  /// Get all unique rooms where this class is held
  List<String> get rooms => schedule.map((p) => p.room).toSet().toList();

  /// Get total hours per week for this class
  double get hoursPerWeek {
    int totalMinutes = 0;
    for (final period in schedule) {
      totalMinutes += period.duration * period.weekdays.length;
    }
    return totalMinutes / 60.0;
  }
}
