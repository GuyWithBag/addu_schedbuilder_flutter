import '../models/class_note.dart';

/// Repository interface for managing class notes
abstract class NotesRepository {
  /// Save a note
  Future<void> save(ClassNote note);

  /// Get all notes
  Future<List<ClassNote>> getAll();

  /// Get notes for a specific class
  Future<List<ClassNote>> getByClassCode(String classCode);

  /// Get a specific note by ID
  Future<ClassNote?> getById(String id);

  /// Delete a note
  Future<void> delete(String id);

  /// Update a note
  Future<void> update(ClassNote note);

  /// Delete all notes for a class
  Future<void> deleteAllForClass(String classCode);
}
