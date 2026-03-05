import 'package:flutter/material.dart';
import '../../domain/models/saved_schedule.dart';
import '../../domain/services/widget_service.dart';

/// Provider for managing home screen widget updates
class WidgetProvider extends ChangeNotifier {
  String? _activeScheduleId;
  bool _autoUpdate = true;
  bool _isUpdating = false;

  String? get activeScheduleId => _activeScheduleId;
  bool get autoUpdate => _autoUpdate;
  bool get isUpdating => _isUpdating;

  /// Set the active schedule for the widget
  Future<void> setActiveSchedule(SavedSchedule? schedule) async {
    _activeScheduleId = schedule?.id;
    notifyListeners();

    if (_autoUpdate) {
      await updateWidget(schedule);
    }
  }

  /// Update the home screen widget
  Future<void> updateWidget(SavedSchedule? schedule) async {
    _isUpdating = true;
    notifyListeners();

    try {
      if (schedule == null) {
        await WidgetService.updateHomeWidget(null, null);
      } else {
        final currentDay = WidgetService.getCurrentWeekday();
        await WidgetService.updateHomeWidget(schedule.table, currentDay);
      }
    } catch (e) {
      debugPrint('Error updating widget: $e');
    } finally {
      _isUpdating = false;
      notifyListeners();
    }
  }

  /// Toggle auto-update
  void setAutoUpdate(bool value) {
    _autoUpdate = value;
    notifyListeners();
  }

  /// Manually trigger widget update
  Future<void> refreshWidget(SavedSchedule? schedule) async {
    await updateWidget(schedule);
  }
}
