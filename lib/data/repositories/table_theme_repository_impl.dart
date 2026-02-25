import 'package:hive_ce/hive.dart';
import '../../domain/models/table_theme.dart';
import '../../domain/repositories/table_theme_repository.dart';

/// Hive CE implementation of TableThemeRepository
class TableThemeRepositoryImpl implements TableThemeRepository {
  static const String _boxName = 'table_themes';
  Box<TableTheme>? _box;

  TableThemeRepositoryImpl() {
    // Ensure the box is opened when repository is created
    _initBox();
  }

  Future<void> _initBox() async {
    try {
      _box = await Hive.openBox<TableTheme>(_boxName);
    } catch (e) {
      // Box might already be open, try to get it
      if (Hive.isBoxOpen(_boxName)) {
        _box = Hive.box<TableTheme>(_boxName);
      }
    }
  }

  Future<Box<TableTheme>> _getBox() async {
    if (_box == null || !_box!.isOpen) {
      _box = await Hive.openBox<TableTheme>(_boxName);
    }
    return _box!;
  }

  @override
  Future<void> save(TableTheme theme) async {
    final box = await _getBox();
    await box.put(theme.id, theme);
  }

  @override
  Future<List<TableTheme>> getAll() async {
    final box = await _getBox();
    return box.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt)); // Newest first
  }

  @override
  Future<TableTheme?> getById(String id) async {
    final box = await _getBox();
    return box.get(id);
  }

  @override
  Future<void> update(TableTheme theme) async {
    final box = await _getBox();
    await box.put(theme.id, theme);
  }

  @override
  Future<void> delete(String id) async {
    final box = await _getBox();
    await box.delete(id);
  }

  @override
  Future<void> deleteAll() async {
    final box = await _getBox();
    await box.clear();
  }
}
