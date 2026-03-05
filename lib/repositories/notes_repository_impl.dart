import 'package:hive_ce/hive.dart';
import '../models/class_note.dart';
import './notes_repository.dart';

/// Hive-based implementation of NotesRepository
class NotesRepositoryImpl implements NotesRepository {
  static const String _boxName = 'class_notes';
  Box<ClassNote>? _box;

  Future<Box<ClassNote>> get _notesBox async {
    if (_box != null && _box!.isOpen) {
      return _box!;
    }
    _box = await Hive.openBox<ClassNote>(_boxName);
    return _box!;
  }

  @override
  Future<void> save(ClassNote note) async {
    final box = await _notesBox;
    await box.put(note.id, note);
  }

  @override
  Future<List<ClassNote>> getAll() async {
    final box = await _notesBox;
    return box.values.toList();
  }

  @override
  Future<List<ClassNote>> getByClassCode(String classCode) async {
    final box = await _notesBox;
    return box.values.where((note) => note.classCode == classCode).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt)); // Newest first
  }

  @override
  Future<ClassNote?> getById(String id) async {
    final box = await _notesBox;
    return box.get(id);
  }

  @override
  Future<void> delete(String id) async {
    final box = await _notesBox;
    await box.delete(id);
  }

  @override
  Future<void> update(ClassNote note) async {
    final box = await _notesBox;
    await box.put(note.id, note);
  }

  @override
  Future<void> deleteAllForClass(String classCode) async {
    final box = await _notesBox;
    final notesToDelete = box.values
        .where((note) => note.classCode == classCode)
        .map((note) => note.id)
        .toList();

    for (final id in notesToDelete) {
      await box.delete(id);
    }
  }
}
