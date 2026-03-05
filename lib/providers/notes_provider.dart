import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/class_note.dart';
import '../models/note_type.dart';
import '../repositories/notes_repository.dart';

/// Provider for managing class notes
class NotesProvider extends ChangeNotifier {
  final NotesRepository _repository;
  Map<String, List<ClassNote>> _notesByClass = {};
  bool _isLoading = false;

  NotesProvider({required NotesRepository repository})
    : _repository = repository;

  Map<String, List<ClassNote>> get notesByClass => _notesByClass;
  bool get isLoading => _isLoading;

  /// Load all notes
  Future<void> loadNotes() async {
    _isLoading = true;
    notifyListeners();

    try {
      final notes = await _repository.getAll();
      _notesByClass = {};

      for (final note in notes) {
        if (!_notesByClass.containsKey(note.classCode)) {
          _notesByClass[note.classCode] = [];
        }
        _notesByClass[note.classCode]!.add(note);
      }

      // Sort each list by creation date (newest first)
      for (final list in _notesByClass.values) {
        list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }
    } catch (e) {
      debugPrint('Error loading notes: $e');
      _notesByClass = {};
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Load notes for a specific class
  Future<List<ClassNote>> loadNotesForClass(String classCode) async {
    try {
      final notes = await _repository.getByClassCode(classCode);
      _notesByClass[classCode] = notes;
      notifyListeners();
      return notes;
    } catch (e) {
      debugPrint('Error loading notes for class $classCode: $e');
      return [];
    }
  }

  /// Add a new note
  Future<void> addNote({
    required String classCode,
    required String content,
    required NoteType type,
  }) async {
    final note = ClassNote(
      id: const Uuid().v4(),
      classCode: classCode,
      content: content,
      createdAt: DateTime.now(),
      type: type,
    );

    try {
      await _repository.save(note);

      if (!_notesByClass.containsKey(classCode)) {
        _notesByClass[classCode] = [];
      }
      _notesByClass[classCode]!.insert(
        0,
        note,
      ); // Add at beginning (newest first)

      notifyListeners();
    } catch (e) {
      debugPrint('Error adding note: $e');
      rethrow;
    }
  }

  /// Update an existing note
  Future<void> updateNote(ClassNote note) async {
    try {
      await _repository.update(note);

      // Update in local cache
      if (_notesByClass.containsKey(note.classCode)) {
        final index = _notesByClass[note.classCode]!.indexWhere(
          (n) => n.id == note.id,
        );
        if (index != -1) {
          _notesByClass[note.classCode]![index] = note;
        }
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Error updating note: $e');
      rethrow;
    }
  }

  /// Delete a note
  Future<void> deleteNote(String id, String classCode) async {
    try {
      await _repository.delete(id);

      // Remove from local cache
      if (_notesByClass.containsKey(classCode)) {
        _notesByClass[classCode]!.removeWhere((note) => note.id == id);
        if (_notesByClass[classCode]!.isEmpty) {
          _notesByClass.remove(classCode);
        }
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting note: $e');
      rethrow;
    }
  }

  /// Delete all notes for a class
  Future<void> deleteAllNotesForClass(String classCode) async {
    try {
      await _repository.deleteAllForClass(classCode);
      _notesByClass.remove(classCode);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting notes for class $classCode: $e');
      rethrow;
    }
  }

  /// Get notes for a specific class (from cache)
  List<ClassNote> getNotesForClass(String classCode) {
    return _notesByClass[classCode] ?? [];
  }

  /// Get note count for a class
  int getNoteCountForClass(String classCode) {
    return _notesByClass[classCode]?.length ?? 0;
  }
}
