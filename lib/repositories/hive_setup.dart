import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../hive_adapters.dart';
import '../models/class_note.dart';
import '../models/notification_config.dart';
import '../models/saved_schedule.dart';
import '../models/theme_preset.dart';
import '../models/table_theme.dart';

/// Initialize Hive CE with all type adapters
Future<void> initHive() async {
  // Get application directory for Hive storage
  final appDir = await getApplicationDocumentsDirectory();

  // Initialize Hive with the app directory
  await Hive.initFlutter(appDir.path);

  // Register all type adapters manually from generated adapters
  Hive.registerAdapter(TimeAdapter());
  Hive.registerAdapter(WeekdayAdapter());
  Hive.registerAdapter(ClassPeriodAdapter());
  Hive.registerAdapter(TeacherAdapter());
  Hive.registerAdapter(ClassDataAdapter());
  Hive.registerAdapter(ClassSlotAdapter());
  Hive.registerAdapter(ScheduleRowAdapter());
  Hive.registerAdapter(ScheduleTableAdapter());
  Hive.registerAdapter(SavedScheduleAdapter());
  Hive.registerAdapter(ThemePresetAdapter());
  Hive.registerAdapter(ClassNoteAdapter());
  Hive.registerAdapter(NoteTypeAdapter());
  Hive.registerAdapter(NotificationConfigAdapter());
  Hive.registerAdapter(BarSlotAdapter());
  Hive.registerAdapter(EmptySlotAdapter());
  Hive.registerAdapter(ColorDataAdapter());
  Hive.registerAdapter(TableThemeAdapter());

  // Open boxes for each entity type
  await Hive.openBox<SavedSchedule>('schedules');
  await Hive.openBox<ClassNote>('notes');
  await Hive.openBox<ThemePreset>('theme_presets');
  await Hive.openBox<NotificationConfig>('notification_config');
  await Hive.openBox<TableTheme>('table_themes');
}

/// Close all Hive boxes (call on app disposal)
Future<void> closeHive() async {
  await Hive.close();
}

/// Get a box by name (type-safe)
Box<T> getBox<T>(String name) {
  return Hive.box<T>(name);
}
