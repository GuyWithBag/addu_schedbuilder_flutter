import 'package:flutter/material.dart';
import '../models/saved_schedule.dart';
import '../models/time_block.dart';
import '../services/schedule_comparison_service.dart';

/// Provider for managing schedule comparison
class ComparisonProvider extends ChangeNotifier {
  Set<String> _selectedScheduleIds = {};
  List<TimeBlock> _commonFreeTime = [];
  Map<String, dynamic> _stats = {};

  Set<String> get selectedScheduleIds => _selectedScheduleIds;
  List<TimeBlock> get commonFreeTime => _commonFreeTime;
  Map<String, dynamic> get stats => _stats;
  bool get hasSelection => _selectedScheduleIds.isNotEmpty;
  bool get hasResults => _commonFreeTime.isNotEmpty;

  /// Toggle schedule selection
  void toggleSchedule(String scheduleId) {
    if (_selectedScheduleIds.contains(scheduleId)) {
      _selectedScheduleIds.remove(scheduleId);
    } else {
      _selectedScheduleIds.add(scheduleId);
    }
    notifyListeners();
  }

  /// Select all schedules
  void selectAll(List<SavedSchedule> schedules) {
    _selectedScheduleIds = schedules.map((s) => s.id).toSet();
    notifyListeners();
  }

  /// Clear all selections
  void clearSelection() {
    _selectedScheduleIds.clear();
    _commonFreeTime.clear();
    _stats = {};
    notifyListeners();
  }

  /// Check if a schedule is selected
  bool isSelected(String scheduleId) {
    return _selectedScheduleIds.contains(scheduleId);
  }

  /// Compare selected schedules
  void compareSchedules(List<SavedSchedule> allSchedules) {
    final selectedSchedules = allSchedules
        .where((s) => _selectedScheduleIds.contains(s.id))
        .toList();

    if (selectedSchedules.isEmpty) {
      _commonFreeTime = [];
      _stats = {};
      notifyListeners();
      return;
    }

    final scheduleTables = selectedSchedules.map((s) => s.table).toList();

    _commonFreeTime = ScheduleComparisonService.findCommonFreeTime(
      scheduleTables,
    );

    _stats = ScheduleComparisonService.getCommonFreeTimeStats(_commonFreeTime);

    notifyListeners();
  }

  /// Get grouped free time by day
  Map<dynamic, List<TimeBlock>> get groupedFreeTime {
    return ScheduleComparisonService.groupFreeTimeByDay(_commonFreeTime);
  }
}
