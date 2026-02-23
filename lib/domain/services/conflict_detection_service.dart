import '../models/class_data.dart';
import '../models/conflict_info.dart';
import '../models/schedule_table.dart';
import '../models/time.dart';
import '../models/weekday.dart';

/// Service for detecting scheduling conflicts (overlapping classes)
class ConflictDetectionService {
  ConflictDetectionService._();

  /// Detect all conflicts in a schedule table
  /// Returns a list of ConflictInfo objects representing overlapping classes
  static List<ConflictInfo> detectConflicts(ScheduleTable table) {
    final conflicts = <ConflictInfo>[];
    final allClasses = table.getAllClasses();

    // Check conflicts for each weekday
    for (final weekday in Weekday.values) {
      final classesOnDay = _getClassesWithPeriods(allClasses, weekday);

      // Compare all pairs of classes on this day
      for (var i = 0; i < classesOnDay.length; i++) {
        for (var j = i + 1; j < classesOnDay.length; j++) {
          final class1 = classesOnDay[i];
          final class2 = classesOnDay[j];

          // Check if time ranges overlap
          if (_timeRangesOverlap(
            class1.period.start,
            class1.period.end,
            class2.period.start,
            class2.period.end,
          )) {
            // Calculate overlap time range
            final overlapStart = _maxTime(
              class1.period.start,
              class2.period.start,
            );
            final overlapEnd = _minTime(class1.period.end, class2.period.end);

            conflicts.add(
              ConflictInfo(
                conflictingClasses: [class1.classData, class2.classData],
                startTime: overlapStart,
                endTime: overlapEnd,
                weekday: weekday,
              ),
            );
          }
        }
      }
    }

    return conflicts;
  }

  /// Get classes with their periods for a specific weekday
  static List<_ClassWithPeriod> _getClassesWithPeriods(
    List<ClassData> classes,
    Weekday weekday,
  ) {
    final result = <_ClassWithPeriod>[];

    for (final classData in classes) {
      for (final period in classData.schedule) {
        if (period.weekdays.contains(weekday)) {
          result.add(_ClassWithPeriod(classData, period));
        }
      }
    }

    return result;
  }

  /// Check if two time ranges overlap
  static bool _timeRangesOverlap(
    Time start1,
    Time end1,
    Time start2,
    Time end2,
  ) {
    // Overlap occurs if: start1 < end2 AND start2 < end1
    return start1.toMinutes() < end2.toMinutes() &&
        start2.toMinutes() < end1.toMinutes();
  }

  /// Get the later of two times
  static Time _maxTime(Time a, Time b) {
    return a.toMinutes() > b.toMinutes() ? a : b;
  }

  /// Get the earlier of two times
  static Time _minTime(Time a, Time b) {
    return a.toMinutes() < b.toMinutes() ? a : b;
  }
}

/// Helper class to associate a class with a specific period
class _ClassWithPeriod {
  final ClassData classData;
  final period;

  _ClassWithPeriod(this.classData, this.period);
}
