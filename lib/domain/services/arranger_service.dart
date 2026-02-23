import '../models/class_data.dart';
import '../models/schedule_row.dart';
import '../models/schedule_table.dart';
import '../models/time.dart';
import '../models/time_slot.dart';
import '../models/weekday.dart';

/// Service for arranging ClassData into a ScheduleTable grid
class ArrangerService {
  ArrangerService._();

  /// Arrange a list of classes into a schedule table grid
  ///
  /// Algorithm:
  /// 1. Extract all unique time slots from all classes
  /// 2. Sort times chronologically
  /// 3. Create grid with rows (time slots) × columns (7 weekdays)
  /// 4. Fill cells with ClassSlot/EmptySlot
  /// 5. Calculate rowspan based on class duration
  static ScheduleTable arrange(List<ClassData> classes) {
    if (classes.isEmpty) {
      return const ScheduleTable(rows: []);
    }

    // Step 1: Extract all unique times
    final times = <Time>{};
    for (final classData in classes) {
      for (final period in classData.schedule) {
        times.add(period.start);
        times.add(period.end);
      }
    }

    // Step 2: Sort times chronologically
    final sortedTimes = times.toList()
      ..sort((a, b) => a.toMinutes().compareTo(b.toMinutes()));

    if (sortedTimes.isEmpty) {
      return const ScheduleTable(rows: []);
    }

    // Step 3: Create grid structure
    final rows = <ScheduleRow>[];
    final timeToRowIndex = <int, int>{};

    for (var i = 0; i < sortedTimes.length - 1; i++) {
      final time = sortedTimes[i];
      final nextTime = sortedTimes[i + 1];
      final duration = time.durationUntil(nextTime);

      timeToRowIndex[time.toMinutes()] = i;

      // Initialize with empty slots for all 7 weekdays (mutable list)
      final columns = List<TimeSlot?>.generate(7, (_) => null);

      rows.add(ScheduleRow(time: time, duration: duration, columns: columns));
    }

    // Step 4: Fill grid with classes
    for (final classData in classes) {
      for (final period in classData.schedule) {
        final startMinutes = period.start.toMinutes();
        final rowIndex = timeToRowIndex[startMinutes];

        if (rowIndex == null) continue;

        // Calculate rowspan
        final endMinutes = period.end.toMinutes();
        var rowspan = 1;
        var currentMinutes = startMinutes;

        for (
          var i = rowIndex;
          i < rows.length && currentMinutes < endMinutes;
          i++
        ) {
          final row = rows[i];
          currentMinutes += row.duration;
          if (i > rowIndex) rowspan++;
        }

        // Fill cells for each weekday this class occurs
        for (final weekday in period.weekdays) {
          final columnIndex = weekday.dayIndex;

          if (columnIndex < rows[rowIndex].columns.length) {
            rows[rowIndex].columns[columnIndex] = TimeSlot.classSlot(
              classData: classData,
              rowspan: rowspan,
              colspan: 1,
              duration: period.duration,
            );
          }
        }
      }
    }

    // Step 5: Fill remaining nulls with empty slots
    for (final row in rows) {
      for (var i = 0; i < row.columns.length; i++) {
        row.columns[i] ??= const TimeSlot.emptySlot();
      }
    }

    // Detect PE weekdays (if needed - placeholder for now)
    final peWeekdays = <Weekday>{};

    return ScheduleTable(rows: rows, peWeekdays: peWeekdays, weekdayConfig: {});
  }

  /// Auto-detect lunch/break periods
  /// Returns a new ScheduleTable with lunch breaks highlighted
  static ScheduleTable detectBreaks(ScheduleTable table) {
    // Look for empty rows between 11 AM and 2 PM that are at least 30 minutes
    final updatedRows = <ScheduleRow>[];

    for (final row in table.rows) {
      final hour = row.time.hour;
      final isLunchTime = hour >= 11 && hour <= 14;
      final hasNoClasses = row.columns.every((slot) => slot is EmptySlot);

      if (isLunchTime && hasNoClasses && row.duration >= 30) {
        // Convert empty slots to bar slots (lunch)
        final lunchColumns = List<TimeSlot>.filled(
          7,
          const TimeSlot.barSlot(label: 'LUNCH'),
        );

        updatedRows.add(row.copyWith(columns: lunchColumns));
      } else {
        updatedRows.add(row);
      }
    }

    return table.copyWith(rows: updatedRows);
  }
}
