import 'package:json_annotation/json_annotation.dart';
import 'class_period.dart';
import 'teacher.dart';

part 'class_data.g.dart';

@JsonSerializable()
class ClassData {
  final String code;
  final String subject;
  final String title;
  final List<ClassPeriod> schedule;
  final Teacher? teacher;
  final int units;

  const ClassData({
    required this.code,
    required this.subject,
    required this.title,
    required this.schedule,
    this.teacher,
    this.units = 3,
  });

  /// JSON serialization
  factory ClassData.fromJson(Map<String, dynamic> json) =>
      _$ClassDataFromJson(json);
  Map<String, dynamic> toJson() => _$ClassDataToJson(this);

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

  /// CopyWith method for immutability
  ClassData copyWith({
    String? code,
    String? subject,
    String? title,
    List<ClassPeriod>? schedule,
    Teacher? teacher,
    int? units,
  }) {
    return ClassData(
      code: code ?? this.code,
      subject: subject ?? this.subject,
      title: title ?? this.title,
      schedule: schedule ?? this.schedule,
      teacher: teacher ?? this.teacher,
      units: units ?? this.units,
    );
  }

  /// Equality and hashCode
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassData &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          subject == other.subject &&
          title == other.title &&
          _listEquals(schedule, other.schedule) &&
          teacher == other.teacher &&
          units == other.units;

  @override
  int get hashCode =>
      code.hashCode ^
      subject.hashCode ^
      title.hashCode ^
      schedule.fold(0, (prev, element) => prev ^ element.hashCode) ^
      (teacher?.hashCode ?? 0) ^
      units.hashCode;

  @override
  String toString() =>
      'ClassData(code: $code, subject: $subject, title: $title, schedule: $schedule, teacher: $teacher, units: $units)';

  static bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
