import 'package:hive_ce/hive.dart';
import '../models/saved_schedule.dart';
import './schedule_repository.dart';
import 'hive_setup.dart';

/// Hive CE implementation of ScheduleRepository
class ScheduleRepositoryImpl implements ScheduleRepository {
  static const String _boxName = 'schedules';

  Box<SavedSchedule> get _box => getBox<SavedSchedule>(_boxName);

  @override
  Future<void> save(SavedSchedule schedule) async {
    await _box.put(schedule.id, schedule);
  }

  @override
  Future<List<SavedSchedule>> getAll() async {
    return _box.values.toList();
  }

  @override
  Future<SavedSchedule?> getById(String id) async {
    return _box.get(id);
  }

  @override
  Future<void> delete(String id) async {
    await _box.delete(id);
  }

  @override
  Future<void> update(SavedSchedule schedule) async {
    // In Hive, update is the same as save (put with same key)
    await _box.put(schedule.id, schedule);
  }

  @override
  Future<List<SavedSchedule>> getBySemester(String semester) async {
    return _box.values
        .where((schedule) => schedule.semester == semester)
        .toList();
  }

  @override
  Future<void> clearAll() async {
    await _box.clear();
  }
}
