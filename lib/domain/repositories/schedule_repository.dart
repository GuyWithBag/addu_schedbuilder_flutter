import '../models/saved_schedule.dart';

/// Abstract repository interface for schedule persistence
/// Implementation will use Hive CE for local storage
abstract class ScheduleRepository {
  /// Save a new schedule
  Future<void> save(SavedSchedule schedule);

  /// Get all saved schedules
  Future<List<SavedSchedule>> getAll();

  /// Get a schedule by ID
  Future<SavedSchedule?> getById(String id);

  /// Delete a schedule by ID
  Future<void> delete(String id);

  /// Update an existing schedule
  Future<void> update(SavedSchedule schedule);

  /// Get schedules filtered by semester
  Future<List<SavedSchedule>> getBySemester(String semester);

  /// Clear all schedules (use with caution)
  Future<void> clearAll();
}
