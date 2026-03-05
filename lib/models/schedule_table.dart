import 'package:json_annotation/json_annotation.dart';
import 'class_data.dart';
import 'schedule_row.dart';
import 'time_slot.dart';
import 'weekday.dart';

part 'schedule_table.g.dart';

@JsonSerializable()
class ScheduleTable {
  final List<ScheduleRow> rows;
  final Set<Weekday> peWeekdays;
  final Map<Weekday, bool> weekdayConfig;

  const ScheduleTable({
    required this.rows,
    this.peWeekdays = const {},
    this.weekdayConfig = const {},
  });

  /// JSON serialization
  factory ScheduleTable.fromJson(Map<String, dynamic> json) =>
      _$ScheduleTableFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleTableToJson(this);

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

  /// CopyWith method for immutability
  ScheduleTable copyWith({
    List<ScheduleRow>? rows,
    Set<Weekday>? peWeekdays,
    Map<Weekday, bool>? weekdayConfig,
  }) {
    return ScheduleTable(
      rows: rows ?? this.rows,
      peWeekdays: peWeekdays ?? this.peWeekdays,
      weekdayConfig: weekdayConfig ?? this.weekdayConfig,
    );
  }

  /// Equality and hashCode
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleTable &&
          runtimeType == other.runtimeType &&
          _listEquals(rows, other.rows) &&
          _setEquals(peWeekdays, other.peWeekdays) &&
          _mapEquals(weekdayConfig, other.weekdayConfig);

  @override
  int get hashCode =>
      rows.fold(0, (prev, element) => prev ^ element.hashCode) ^
      peWeekdays.fold(0, (prev, element) => prev ^ element.hashCode) ^
      weekdayConfig.entries.fold(
        0,
        (prev, entry) => prev ^ entry.key.hashCode ^ entry.value.hashCode,
      );

  @override
  String toString() =>
      'ScheduleTable(rows: $rows, peWeekdays: $peWeekdays, weekdayConfig: $weekdayConfig)';

  static bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  static bool _setEquals<T>(Set<T>? a, Set<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    return a.containsAll(b);
  }

  static bool _mapEquals<K, V>(Map<K, V>? a, Map<K, V>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key) || a[key] != b[key]) return false;
    }
    return true;
  }
}
