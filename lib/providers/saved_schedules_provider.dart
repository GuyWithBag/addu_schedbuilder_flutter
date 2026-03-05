import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/saved_schedule.dart';
import '../models/schedule_table.dart';
import '../models/theme_preset.dart';
import '../repositories/schedule_repository.dart';
import '../services/color_service.dart';

/// Provider for managing saved schedules
class SavedSchedulesProvider extends ChangeNotifier {
  final ScheduleRepository _repository;
  List<SavedSchedule> _schedules = [];
  String? _currentScheduleId;
  bool _isLoading = false;

  SavedSchedulesProvider({required ScheduleRepository repository})
    : _repository = repository;

  List<SavedSchedule> get schedules => _schedules;
  String? get currentScheduleId => _currentScheduleId;
  bool get isLoading => _isLoading;

  /// Load all schedules from storage
  Future<void> loadSchedules() async {
    _isLoading = true;
    notifyListeners();

    try {
      _schedules = await _repository.getAll();
      // Sort by creation date (newest first)
      _schedules.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      debugPrint('Error loading schedules: $e');
      _schedules = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Save a new schedule (or restore an existing one with specific id)
  Future<void> saveSchedule(
    String name,
    ScheduleTable table,
    String? semester,
    Map<String, ColorSet> classColors, {
    String? id, // Optional: for restoring deleted schedules with same ID
    String? inputText, // Optional: original input text that was parsed
  }) async {
    // Convert ColorSet to ColorData for storage
    final colorDataMap = <String, ColorData>{};
    for (final entry in classColors.entries) {
      final color = entry.value.primary;
      colorDataMap[entry.key] = ColorData(
        red: color.red,
        green: color.green,
        blue: color.blue,
        alpha: color.alpha,
      );
    }

    final themePreset = ThemePreset(
      id: const Uuid().v4(),
      name: 'Default Theme',
      classColors: colorDataMap,
      isDarkMode: false, // Will be set from DisplayConfigProvider in the future
    );

    final schedule = SavedSchedule(
      id: id ?? const Uuid().v4(), // Use provided ID or generate new one
      name: name,
      createdAt: DateTime.now(),
      table: table,
      semester: semester,
      themePreset: themePreset,
      inputText: inputText, // Save the original input text
    );

    try {
      await _repository.save(schedule);
      await loadSchedules(); // Reload to update UI
    } catch (e) {
      debugPrint('Error saving schedule: $e');
      rethrow;
    }
  }

  /// Save a schedule from import (QR code, JSON, etc.)
  Future<void> saveScheduleFromImport(SavedSchedule schedule) async {
    try {
      await _repository.save(schedule);
      await loadSchedules();
    } catch (e) {
      debugPrint('Error saving imported schedule: $e');
      rethrow;
    }
  }

  /// Delete a schedule
  Future<void> deleteSchedule(String id) async {
    try {
      await _repository.delete(id);

      if (_currentScheduleId == id) {
        _currentScheduleId = null;
      }

      await loadSchedules();
    } catch (e) {
      debugPrint('Error deleting schedule: $e');
      rethrow;
    }
  }

  /// Load a specific schedule (set as current)
  Future<SavedSchedule?> loadScheduleById(String id) async {
    try {
      final schedule = await _repository.getById(id);

      if (schedule != null) {
        _currentScheduleId = id;
        notifyListeners();
      }

      return schedule;
    } catch (e) {
      debugPrint('Error loading schedule: $e');
      return null;
    }
  }

  /// Filter schedules by semester
  Future<List<SavedSchedule>> filterBySemester(String semester) async {
    try {
      return await _repository.getBySemester(semester);
    } catch (e) {
      debugPrint('Error filtering schedules: $e');
      return [];
    }
  }

  /// Update an existing schedule
  Future<void> updateSchedule(SavedSchedule schedule) async {
    try {
      await _repository.update(schedule);
      await loadSchedules();
    } catch (e) {
      debugPrint('Error updating schedule: $e');
      rethrow;
    }
  }

  /// Get unique semesters from all schedules
  List<String> getUniqueSemesters() {
    final semesters = _schedules
        .where((s) => s.semester != null)
        .map((s) => s.semester!)
        .toSet()
        .toList();

    semesters.sort();
    return semesters;
  }
}
