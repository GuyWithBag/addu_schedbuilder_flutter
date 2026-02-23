import 'package:hive_ce/hive.dart';
import 'domain/models/time.dart';
import 'domain/models/weekday.dart';
import 'domain/models/class_period.dart';
import 'domain/models/teacher.dart';
import 'domain/models/class_data.dart';
import 'domain/models/time_slot.dart';
import 'domain/models/schedule_row.dart';
import 'domain/models/schedule_table.dart';
import 'domain/models/saved_schedule.dart';
import 'domain/models/theme_preset.dart';
import 'domain/models/class_note.dart';
import 'domain/models/note_type.dart';
import 'domain/models/notification_config.dart';

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
])
part 'hive_adapters.g.dart';
