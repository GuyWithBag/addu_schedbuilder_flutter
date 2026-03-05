import '../models/table_theme.dart';

/// Abstract repository for table theme persistence
abstract class TableThemeRepository {
  /// Save a table theme
  Future<void> save(TableTheme theme);

  /// Get all saved table themes
  Future<List<TableTheme>> getAll();

  /// Get a table theme by ID
  Future<TableTheme?> getById(String id);

  /// Update an existing table theme
  Future<void> update(TableTheme theme);

  /// Delete a table theme by ID
  Future<void> delete(String id);

  /// Delete all table themes
  Future<void> deleteAll();
}
