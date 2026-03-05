import 'package:home_widget/home_widget.dart';
import '../models/class_data.dart';
import '../models/schedule_table.dart';
import '../models/time.dart';
import '../models/weekday.dart';

/// Service for updating home screen widgets
class WidgetService {
  /// Update the home widget with today's schedule
  static Future<void> updateHomeWidget(
    ScheduleTable? table,
    Weekday? currentDay,
  ) async {
    if (table == null || currentDay == null) {
      await _clearWidget();
      return;
    }

    final todayClasses = getTodayClasses(table, currentDay);

    // Prepare widget data
    await HomeWidget.saveWidgetData<String>(
      'widget_title',
      _formatDayName(currentDay),
    );

    if (todayClasses.isEmpty) {
      await HomeWidget.saveWidgetData<String>(
        'widget_message',
        'No classes today',
      );
      await HomeWidget.saveWidgetData<int>('class_count', 0);
    } else {
      await HomeWidget.saveWidgetData<String>(
        'widget_message',
        '${todayClasses.length} classes today',
      );
      await HomeWidget.saveWidgetData<int>('class_count', todayClasses.length);

      // Save first 5 classes (widget space is limited)
      final classesToShow = todayClasses.take(5).toList();
      for (int i = 0; i < classesToShow.length; i++) {
        final classData = classesToShow[i];
        final period = classData.schedule.first;

        await HomeWidget.saveWidgetData<String>(
          'class_${i}_subject',
          classData.subject,
        );
        await HomeWidget.saveWidgetData<String>(
          'class_${i}_code',
          classData.code,
        );
        await HomeWidget.saveWidgetData<String>(
          'class_${i}_time',
          '${period.start.format(false)} - ${period.end.format(false)}',
        );
        await HomeWidget.saveWidgetData<String>('class_${i}_room', period.room);
      }
    }

    // Update the widget
    await HomeWidget.updateWidget(
      name: 'SchedBuilderWidgetProvider',
      androidName: 'SchedBuilderWidgetProvider',
      iOSName: 'SchedBuilderWidget',
    );
  }

  /// Get classes for a specific day
  static List<ClassData> getTodayClasses(
    ScheduleTable table,
    Weekday currentDay,
  ) {
    final allClasses = table.getAllClasses();
    final todayClasses = <ClassData>[];

    for (final classData in allClasses) {
      for (final period in classData.schedule) {
        if (period.weekdays.contains(currentDay)) {
          todayClasses.add(classData);
          break; // Only add each class once
        }
      }
    }

    // Sort by start time
    todayClasses.sort((a, b) {
      final aStart = a.schedule.first.start;
      final bStart = b.schedule.first.start;
      return aStart.toMinutes().compareTo(bStart.toMinutes());
    });

    return todayClasses;
  }

  /// Get the next upcoming class
  static ClassData? getNextClass(
    ScheduleTable table,
    Weekday currentDay,
    Time currentTime,
  ) {
    final todayClasses = getTodayClasses(table, currentDay);
    final currentMinutes = currentTime.toMinutes();

    for (final classData in todayClasses) {
      final startMinutes = classData.schedule.first.start.toMinutes();
      if (startMinutes > currentMinutes) {
        return classData;
      }
    }

    return null;
  }

  /// Get the current ongoing class
  static ClassData? getCurrentClass(
    ScheduleTable table,
    Weekday currentDay,
    Time currentTime,
  ) {
    final todayClasses = getTodayClasses(table, currentDay);
    final currentMinutes = currentTime.toMinutes();

    for (final classData in todayClasses) {
      final period = classData.schedule.first;
      final startMinutes = period.start.toMinutes();
      final endMinutes = period.end.toMinutes();

      if (currentMinutes >= startMinutes && currentMinutes < endMinutes) {
        return classData;
      }
    }

    return null;
  }

  /// Clear widget data
  static Future<void> _clearWidget() async {
    await HomeWidget.saveWidgetData<String>('widget_title', 'SchedBuilder');
    await HomeWidget.saveWidgetData<String>(
      'widget_message',
      'No schedule set',
    );
    await HomeWidget.saveWidgetData<int>('class_count', 0);

    await HomeWidget.updateWidget(
      name: 'SchedBuilderWidgetProvider',
      androidName: 'SchedBuilderWidgetProvider',
      iOSName: 'SchedBuilderWidget',
    );
  }

  /// Format day name
  static String _formatDayName(Weekday day) {
    switch (day) {
      case Weekday.monday:
        return 'Monday';
      case Weekday.tuesday:
        return 'Tuesday';
      case Weekday.wednesday:
        return 'Wednesday';
      case Weekday.thursday:
        return 'Thursday';
      case Weekday.friday:
        return 'Friday';
      case Weekday.saturday:
        return 'Saturday';
      case Weekday.sunday:
        return 'Sunday';
    }
  }

  /// Get current weekday
  static Weekday getCurrentWeekday() {
    final now = DateTime.now();
    switch (now.weekday) {
      case DateTime.monday:
        return Weekday.monday;
      case DateTime.tuesday:
        return Weekday.tuesday;
      case DateTime.wednesday:
        return Weekday.wednesday;
      case DateTime.thursday:
        return Weekday.thursday;
      case DateTime.friday:
        return Weekday.friday;
      case DateTime.saturday:
        return Weekday.saturday;
      case DateTime.sunday:
        return Weekday.sunday;
      default:
        return Weekday.monday;
    }
  }

  /// Get current time
  static Time getCurrentTime() {
    final now = DateTime.now();
    return Time(hour: now.hour, minute: now.minute);
  }
}
