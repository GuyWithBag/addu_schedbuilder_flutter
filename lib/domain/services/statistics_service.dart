import '../models/schedule_table.dart';
import '../models/weekday.dart';

/// Service for calculating schedule statistics
class StatisticsService {
  StatisticsService._();

  /// Calculate total hours per week across all classes
  static double calculateTotalHours(ScheduleTable table) {
    final classes = table.getAllClasses();
    return classes.fold(0.0, (sum, classData) => sum + classData.hoursPerWeek);
  }

  /// Get the busiest weekday (most class hours)
  static Weekday getBusiestDay(ScheduleTable table) {
    final hoursPerDay = getAverageHoursPerDay(table);

    if (hoursPerDay.isEmpty) {
      return Weekday.monday; // Default
    }

    var busiestDay = hoursPerDay.keys.first;
    var maxHours = hoursPerDay.values.first;

    for (final entry in hoursPerDay.entries) {
      if (entry.value > maxHours) {
        maxHours = entry.value;
        busiestDay = entry.key;
      }
    }

    return busiestDay;
  }

  /// Get hours per day for each weekday
  static Map<Weekday, double> getAverageHoursPerDay(ScheduleTable table) {
    final hoursPerDay = <Weekday, double>{};

    for (final weekday in Weekday.values) {
      final classesOnDay = table.getClassesForWeekday(weekday);
      double totalMinutes = 0;

      for (final classData in classesOnDay) {
        for (final period in classData.schedule) {
          if (period.weekdays.contains(weekday)) {
            totalMinutes += period.duration;
          }
        }
      }

      hoursPerDay[weekday] = totalMinutes / 60.0;
    }

    return hoursPerDay;
  }

  /// Count total number of unique classes
  static int countClasses(ScheduleTable table) {
    return table.getAllClasses().length;
  }

  /// Get time distribution (morning/afternoon/evening)
  /// Returns map with counts for each time period
  static Map<String, int> getTimeDistribution(ScheduleTable table) {
    final distribution = {
      'morning': 0, // 6 AM - 12 PM
      'afternoon': 0, // 12 PM - 5 PM
      'evening': 0, // 5 PM - 10 PM
    };

    final classes = table.getAllClasses();

    for (final classData in classes) {
      for (final period in classData.schedule) {
        final hour = period.start.hour;

        if (hour >= 6 && hour < 12) {
          distribution['morning'] = distribution['morning']! + 1;
        } else if (hour >= 12 && hour < 17) {
          distribution['afternoon'] = distribution['afternoon']! + 1;
        } else if (hour >= 17 && hour < 22) {
          distribution['evening'] = distribution['evening']! + 1;
        }
      }
    }

    return distribution;
  }

  /// Get average class duration in minutes
  static double getAverageClassDuration(ScheduleTable table) {
    final classes = table.getAllClasses();
    if (classes.isEmpty) return 0;

    int totalMinutes = 0;
    int periodCount = 0;

    for (final classData in classes) {
      for (final period in classData.schedule) {
        totalMinutes += period.duration;
        periodCount++;
      }
    }

    return periodCount > 0 ? totalMinutes / periodCount : 0;
  }

  /// Get earliest class start time
  static String getEarliestClassTime(ScheduleTable table, bool is24Hour) {
    final classes = table.getAllClasses();
    if (classes.isEmpty) return 'N/A';

    int earliestMinutes = 24 * 60; // Start with end of day

    for (final classData in classes) {
      for (final period in classData.schedule) {
        final minutes = period.start.toMinutes();
        if (minutes < earliestMinutes) {
          earliestMinutes = minutes;
        }
      }
    }

    if (earliestMinutes == 24 * 60) return 'N/A';

    final time = earliestMinutes ~/ 60;
    final minute = earliestMinutes % 60;

    if (is24Hour) {
      return '${time.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    } else {
      final period = time >= 12 ? 'PM' : 'AM';
      final displayHour = time == 0 ? 12 : (time > 12 ? time - 12 : time);
      return '$displayHour:${minute.toString().padLeft(2, '0')} $period';
    }
  }

  /// Get latest class end time
  static String getLatestClassTime(ScheduleTable table, bool is24Hour) {
    final classes = table.getAllClasses();
    if (classes.isEmpty) return 'N/A';

    int latestMinutes = 0;

    for (final classData in classes) {
      for (final period in classData.schedule) {
        final minutes = period.end.toMinutes();
        if (minutes > latestMinutes) {
          latestMinutes = minutes;
        }
      }
    }

    if (latestMinutes == 0) return 'N/A';

    final time = latestMinutes ~/ 60;
    final minute = latestMinutes % 60;

    if (is24Hour) {
      return '${time.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    } else {
      final period = time >= 12 ? 'PM' : 'AM';
      final displayHour = time == 0 ? 12 : (time > 12 ? time - 12 : time);
      return '$displayHour:${minute.toString().padLeft(2, '0')} $period';
    }
  }
}
