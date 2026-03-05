import 'package:hive_ce/hive.dart';
import 'models/time.dart';
import 'models/weekday.dart';
import 'models/class_period.dart';
import 'models/teacher.dart';
import 'models/class_data.dart';
import 'models/time_slot.dart';
import 'models/schedule_row.dart';
import 'models/schedule_table.dart';
import 'models/saved_schedule.dart';
import 'models/theme_preset.dart';
import 'models/class_note.dart';
import 'models/note_type.dart';
import 'models/notification_config.dart';
import 'models/table_theme.dart';

@GenerateAdapters([
  AdapterSpec<Time>(),
  AdapterSpec<Weekday>(),
  AdapterSpec<ClassPeriod>(),
  AdapterSpec<Teacher>(),
  AdapterSpec<ClassData>(),
  AdapterSpec<ClassSlot>(),
  AdapterSpec<ScheduleRow>(),
  AdapterSpec<ScheduleTable>(),
  AdapterSpec<SavedSchedule>(),
  AdapterSpec<ThemePreset>(),
  AdapterSpec<ClassNote>(),
  AdapterSpec<NoteType>(),
  AdapterSpec<NotificationConfig>(),
  AdapterSpec<BarSlot>(),
  AdapterSpec<EmptySlot>(),
  AdapterSpec<ColorData>(),
  AdapterSpec<TableTheme>(),
])
part 'hive_adapters.g.dart';
