import 'package:hive_ce/hive.dart';
import '../../domain/models/class_note.dart';
import '../../domain/repositories/notes_repository.dart';
import '../local/hive_setup.dart';

/// Hive CE implementation of NotesRepository
class NotesRepositoryImpl implements NotesRepository {
  static const String _boxName = 'notes';

  Box<ClassNote> get _box => getBox<ClassNote>(_boxName);

  @override
  Future<void> save(ClassNote note) async {
    await _box.put(note.id, note);
  }

  @override
  Future<List<ClassNote>> getByClassCode(String classCode) async {
    return _box.values.where((note) => note.classCode == classCode).toList();
  }

  @override
  Future<List<ClassNote>> getAll() async {
    return _box.values.toList();
  }

  @override
  Future<void> delete(String id) async {
    await _box.delete(id);
  }

  @override
  Future<void> update(ClassNote note) async {
    await _box.put(note.id, note);
  }

  @override
  Future<void> deleteByClassCode(String classCode) async {
    final notesToDelete = _box.values
        .where((note) => note.classCode == classCode)
        .map((note) => note.id)
        .toList();

    for (final id in notesToDelete) {
      await _box.delete(id);
    }
  }

  @override
  Future<void> clearAll() async {
    await _box.clear();
  }
}
