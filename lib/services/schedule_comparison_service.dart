import '../models/schedule_table.dart';
import '../models/time_block.dart';
import '../models/time.dart';
import '../models/weekday.dart';

/// Service for comparing schedules and finding common free time
class ScheduleComparisonService {
  /// Find common free time blocks across multiple schedules
  static List<TimeBlock> findCommonFreeTime(
    List<ScheduleTable> schedules, {
    Time? startTime,
    Time? endTime,
  }) {
    if (schedules.isEmpty) return [];
    if (schedules.length == 1) {
      return _getFreeTimeBlocks(schedules.first, startTime, endTime);
    }

    // Get all busy time blocks from all schedules
    final allBusyBlocks = <TimeBlock>[];
    for (final schedule in schedules) {
      allBusyBlocks.addAll(_getBusyTimeBlocks(schedule));
    }

    // Determine time range
    final effectiveStartTime = startTime ?? _getEarliestTime(schedules);
    final effectiveEndTime = endTime ?? _getLatestTime(schedules);

    // Find free time for each weekday
    final commonFreeBlocks = <TimeBlock>[];
    for (final weekday in Weekday.values) {
      final busyOnThisDay =
          allBusyBlocks.where((block) => block.weekday == weekday).toList()
            ..sort(
              (a, b) =>
                  a.startTime.toMinutes().compareTo(b.startTime.toMinutes()),
            );

      final freeBlocks = _calculateFreeBlocks(
        weekday,
        busyOnThisDay,
        effectiveStartTime,
        effectiveEndTime,
      );

      commonFreeBlocks.addAll(freeBlocks);
    }

    return commonFreeBlocks;
  }

  /// Get all busy time blocks from a schedule
  static List<TimeBlock> _getBusyTimeBlocks(ScheduleTable schedule) {
    final busyBlocks = <TimeBlock>[];
    final classes = schedule.getAllClasses();

    for (final classData in classes) {
      for (final period in classData.schedule) {
        for (final weekday in period.weekdays) {
          busyBlocks.add(
            TimeBlock(
              weekday: weekday,
              startTime: period.start,
              endTime: period.end,
              isBusy: true,
              label: '${classData.code} - ${classData.subject}',
            ),
          );
        }
      }
    }

    return busyBlocks;
  }

  /// Get free time blocks for a single schedule
  static List<TimeBlock> _getFreeTimeBlocks(
    ScheduleTable schedule,
    Time? startTime,
    Time? endTime,
  ) {
    final busyBlocks = _getBusyTimeBlocks(schedule);
    final effectiveStartTime = startTime ?? _getEarliestTime([schedule]);
    final effectiveEndTime = endTime ?? _getLatestTime([schedule]);

    final freeBlocks = <TimeBlock>[];
    for (final weekday in Weekday.values) {
      final busyOnThisDay =
          busyBlocks.where((block) => block.weekday == weekday).toList()..sort(
            (a, b) =>
                a.startTime.toMinutes().compareTo(b.startTime.toMinutes()),
          );

      freeBlocks.addAll(
        _calculateFreeBlocks(
          weekday,
          busyOnThisDay,
          effectiveStartTime,
          effectiveEndTime,
        ),
      );
    }

    return freeBlocks;
  }

  /// Calculate free time blocks for a specific weekday
  static List<TimeBlock> _calculateFreeBlocks(
    Weekday weekday,
    List<TimeBlock> busyBlocks,
    Time startTime,
    Time endTime,
  ) {
    final freeBlocks = <TimeBlock>[];

    if (busyBlocks.isEmpty) {
      // Entire day is free
      freeBlocks.add(
        TimeBlock(
          weekday: weekday,
          startTime: startTime,
          endTime: endTime,
          isBusy: false,
        ),
      );
      return freeBlocks;
    }

    // Check free time before first class
    final firstBusy = busyBlocks.first;
    if (firstBusy.startTime.toMinutes() > startTime.toMinutes()) {
      freeBlocks.add(
        TimeBlock(
          weekday: weekday,
          startTime: startTime,
          endTime: firstBusy.startTime,
          isBusy: false,
        ),
      );
    }

    // Check free time between classes
    for (var i = 0; i < busyBlocks.length - 1; i++) {
      final currentEnd = busyBlocks[i].endTime;
      final nextStart = busyBlocks[i + 1].startTime;

      if (nextStart.toMinutes() > currentEnd.toMinutes()) {
        freeBlocks.add(
          TimeBlock(
            weekday: weekday,
            startTime: currentEnd,
            endTime: nextStart,
            isBusy: false,
          ),
        );
      }
    }

    // Check free time after last class
    final lastBusy = busyBlocks.last;
    if (lastBusy.endTime.toMinutes() < endTime.toMinutes()) {
      freeBlocks.add(
        TimeBlock(
          weekday: weekday,
          startTime: lastBusy.endTime,
          endTime: endTime,
          isBusy: false,
        ),
      );
    }

    return freeBlocks;
  }

  /// Get the earliest class time across all schedules
  static Time _getEarliestTime(List<ScheduleTable> schedules) {
    var earliestMinutes = 24 * 60; // Start with end of day

    for (final schedule in schedules) {
      for (final row in schedule.rows) {
        final minutes = row.time.toMinutes();
        if (minutes < earliestMinutes) {
          earliestMinutes = minutes;
        }
      }
    }

    return Time.fromMinutes(earliestMinutes);
  }

  /// Get the latest class time across all schedules
  static Time _getLatestTime(List<ScheduleTable> schedules) {
    var latestMinutes = 0;

    for (final schedule in schedules) {
      for (final row in schedule.rows) {
        final endMinutes = row.time.toMinutes() + row.duration;
        if (endMinutes > latestMinutes) {
          latestMinutes = endMinutes;
        }
      }
    }

    return Time.fromMinutes(latestMinutes);
  }

  /// Format common free time as a readable summary
  static Map<Weekday, List<TimeBlock>> groupFreeTimeByDay(
    List<TimeBlock> freeBlocks,
  ) {
    final grouped = <Weekday, List<TimeBlock>>{};

    for (final block in freeBlocks) {
      grouped.putIfAbsent(block.weekday, () => []).add(block);
    }

    // Sort blocks within each day
    for (final blocks in grouped.values) {
      blocks.sort(
        (a, b) => a.startTime.toMinutes().compareTo(b.startTime.toMinutes()),
      );
    }

    return grouped;
  }

  /// Get statistics about common free time
  static Map<String, dynamic> getCommonFreeTimeStats(
    List<TimeBlock> freeBlocks,
  ) {
    var totalMinutes = 0;
    final daysWithFreeTime = <Weekday>{};

    for (final block in freeBlocks) {
      totalMinutes += block.durationMinutes;
      daysWithFreeTime.add(block.weekday);
    }

    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;

    return {
      'totalHours': hours,
      'totalMinutes': minutes,
      'daysWithFreeTime': daysWithFreeTime.length,
      'blockCount': freeBlocks.length,
    };
  }
}
