import '../models/class_note.dart';

/// Abstract repository interface for class notes persistence
/// Implementation will use Hive CE for local storage
abstract class NotesRepository {
  /// Save a new note
  Future<void> save(ClassNote note);

  /// Get all notes for a specific class
  Future<List<ClassNote>> getByClassCode(String classCode);

  /// Get all notes
  Future<List<ClassNote>> getAll();

  /// Delete a note by ID
  Future<void> delete(String id);

  /// Update an existing note
  Future<void> update(ClassNote note);

  /// Delete all notes for a specific class
  Future<void> deleteByClassCode(String classCode);

  /// Clear all notes (use with caution)
  Future<void> clearAll();
}
