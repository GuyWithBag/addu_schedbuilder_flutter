import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/table_theme.dart';
import '../models/theme_preset.dart';
import '../repositories/table_theme_repository.dart';
import 'display_config_provider.dart';

/// Provider for managing table themes
class TableThemeProvider extends ChangeNotifier {
  final TableThemeRepository _repository;
  List<TableTheme> _themes = [];
  bool _isLoading = false;

  TableThemeProvider({required TableThemeRepository repository})
    : _repository = repository;

  List<TableTheme> get themes => _themes;
  bool get isLoading => _isLoading;

  /// Load all saved themes
  Future<void> loadThemes() async {
    _isLoading = true;
    notifyListeners();

    try {
      _themes = await _repository.getAll();
    } catch (e) {
      debugPrint('Error loading table themes: $e');
      _themes = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Save current table customizations as a new theme
  Future<void> saveTheme({
    required String name,
    required DisplayConfigProvider displayConfig,
  }) async {
    final theme = TableTheme(
      id: const Uuid().v4(),
      name: name,
      createdAt: DateTime.now(),
      tableBorderColor: _colorToColorData(displayConfig.tableBorderColor),
      tableBackgroundColor: _colorToColorData(
        displayConfig.tableBackgroundColor,
      ),
      cornerRadius: displayConfig.cornerRadius,
      backgroundImagePath: displayConfig.backgroundImagePath,
      weekdayColors: displayConfig.weekdayColors.map(
        (key, value) => MapEntry(key, _colorToColorData(value)),
      ),
    );

    try {
      await _repository.save(theme);
      _themes.insert(0, theme); // Add to beginning
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving table theme: $e');
      rethrow;
    }
  }

  /// Apply a saved theme to display config
  void applyTheme(TableTheme theme, DisplayConfigProvider displayConfig) {
    displayConfig.updateTableBorderColor(
      _colorDataToColor(theme.tableBorderColor),
    );
    displayConfig.updateTableBackgroundColor(
      _colorDataToColor(theme.tableBackgroundColor),
    );
    displayConfig.updateCornerRadius(theme.cornerRadius);
    displayConfig.setBackgroundImage(theme.backgroundImagePath);

    // Apply weekday colors
    for (final entry in theme.weekdayColors.entries) {
      displayConfig.updateWeekdayColor(
        entry.key,
        _colorDataToColor(entry.value),
      );
    }
  }

  /// Update an existing theme
  Future<void> updateTheme(TableTheme theme) async {
    try {
      await _repository.update(theme);
      final index = _themes.indexWhere((t) => t.id == theme.id);
      if (index != -1) {
        _themes[index] = theme;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating table theme: $e');
      rethrow;
    }
  }

  /// Delete a theme
  Future<void> deleteTheme(String id) async {
    try {
      await _repository.delete(id);
      _themes.removeWhere((theme) => theme.id == id);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting table theme: $e');
      rethrow;
    }
  }

  /// Delete all themes
  Future<void> deleteAllThemes() async {
    try {
      await _repository.deleteAll();
      _themes.clear();
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting all table themes: $e');
      rethrow;
    }
  }

  /// Get theme by ID
  TableTheme? getThemeById(String id) {
    try {
      return _themes.firstWhere((theme) => theme.id == id);
    } catch (e) {
      return null;
    }
  }

  // Helper methods to convert between Color and ColorData
  ColorData _colorToColorData(Color color) {
    return ColorData(
      alpha: (color.a * 255.0).round().clamp(0, 255),
      red: (color.r * 255.0).round().clamp(0, 255),
      green: (color.g * 255.0).round().clamp(0, 255),
      blue: (color.b * 255.0).round().clamp(0, 255),
    );
  }

  Color _colorDataToColor(ColorData colorData) {
    return Color.fromARGB(
      colorData.alpha,
      colorData.red,
      colorData.green,
      colorData.blue,
    );
  }
}
