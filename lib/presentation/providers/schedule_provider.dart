import 'package:flutter/foundation.dart';
import '../../domain/models/schedule_table.dart';
import '../../domain/services/arranger_service.dart';
import '../../domain/services/parser_service.dart';

/// Provider for managing the current schedule being created/edited
class ScheduleProvider extends ChangeNotifier {
  String _inputText = '';
  ParseResult? _parseResult;
  ScheduleTable? _scheduleTable;
  bool _isLoading = false;
  String? _currentScheduleId; // Track which saved schedule is currently loaded

  String get inputText => _inputText;
  ParseResult? get parseResult => _parseResult;
  ScheduleTable? get scheduleTable => _scheduleTable;
  bool get isLoading => _isLoading;
  String? get currentScheduleId => _currentScheduleId;

  /// Update input text
  void updateInput(String text) {
    _inputText = text;
    notifyListeners();
  }

  /// Parse input text and arrange into schedule table
  Future<void> parseAndArrange() async {
    if (_inputText.trim().isEmpty) {
      _parseResult = const ParseResult.failure(['Input is empty']);
      _scheduleTable = null;
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      // Parse the input text
      _parseResult = ParserService.parse(_inputText);

      if (_parseResult!.isSuccess && _parseResult!.classes != null) {
        // Arrange classes into a schedule table
        _scheduleTable = ArrangerService.arrange(_parseResult!.classes!);

        // Optionally detect breaks
        _scheduleTable = ArrangerService.detectBreaks(_scheduleTable!);
      } else {
        _scheduleTable = null;
      }
    } catch (e) {
      _parseResult = ParseResult.failure(['Unexpected error: ${e.toString()}']);
      _scheduleTable = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clear the current schedule
  void clearSchedule() {
    _inputText = '';
    _parseResult = null;
    _scheduleTable = null;
    _currentScheduleId = null;
    notifyListeners();
  }

  /// Load a schedule table directly (e.g., from saved schedule)
  void loadScheduleTable(ScheduleTable table, {String? scheduleId}) {
    _scheduleTable = table;
    _parseResult = null;
    _inputText = '';
    _currentScheduleId = scheduleId;
    notifyListeners();
  }
}
