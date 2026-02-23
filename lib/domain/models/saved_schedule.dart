import 'package:json_annotation/json_annotation.dart';
import 'schedule_table.dart';
import 'theme_preset.dart';

part 'saved_schedule.g.dart';

@JsonSerializable()
class SavedSchedule {
  final String id;
  final String name;
  final DateTime createdAt;
  final ScheduleTable table;
  final String? semester;
  final ThemePreset? themePreset;

  const SavedSchedule({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.table,
    this.semester,
    this.themePreset,
  });

  /// JSON serialization
  factory SavedSchedule.fromJson(Map<String, dynamic> json) =>
      _$SavedScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$SavedScheduleToJson(this);

  /// Get total number of classes in this schedule
  int get classCount => table.getAllClasses().length;

  /// Get total hours per week
  double get totalHoursPerWeek {
    return table.getAllClasses().fold(
      0.0,
      (sum, classData) => sum + classData.hoursPerWeek,
    );
  }

  /// CopyWith method for immutability
  SavedSchedule copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    ScheduleTable? table,
    String? semester,
    ThemePreset? themePreset,
  }) {
    return SavedSchedule(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      table: table ?? this.table,
      semester: semester ?? this.semester,
      themePreset: themePreset ?? this.themePreset,
    );
  }

  /// Equality and hashCode
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedSchedule &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          createdAt == other.createdAt &&
          table == other.table &&
          semester == other.semester &&
          themePreset == other.themePreset;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      createdAt.hashCode ^
      table.hashCode ^
      (semester?.hashCode ?? 0) ^
      (themePreset?.hashCode ?? 0);

  @override
  String toString() =>
      'SavedSchedule(id: $id, name: $name, createdAt: $createdAt, table: $table, semester: $semester, themePreset: $themePreset)';
}
