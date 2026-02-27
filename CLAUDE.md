# SchedBuilder Flutter App - Complete Implementation Guide

## Project Overview

**SchedBuilder** is a Flutter application that helps students parse, visualize, and manage their class schedules. The app uses clean architecture principles with a three-layer structure (Presentation/Domain/Data).

**Current Status:** Phase 1 Complete (Dependencies + Domain Models)
- ✅ All dependencies added to `pubspec.yaml`
- ✅ All domain models created with freezed annotations
- ✅ Hive type adapters configured (typeId 0-11)
- ✅ Build runner executed successfully
- ⏳ Ready to begin Phase 2: Domain Services

---

## Architecture

```
┌─────────────────────────────────────┐
│     PRESENTATION LAYER              │
│  (Flutter Widgets + Providers)      │
│  - Widgets (hooks-based)            │
│  - ChangeNotifier providers         │
│  - UI state management              │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│       DOMAIN LAYER                  │
│    (Pure Dart - No Flutter)         │
│  - Models (freezed)                 │
│  - Services (stateless)             │
│  - Repository interfaces            │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│        DATA LAYER                   │
│   (Hive Persistence)                │
│  - Repository implementations       │
│  - Hive adapters                    │
│  - Local storage                    │
└─────────────────────────────────────┘
```

---

## Technology Stack

| Category | Package | Version | Purpose |
|----------|---------|---------|---------|
| State Management | `provider` | ^6.1.2 | ChangeNotifier pattern |
| Hooks | `flutter_hooks` | ^0.20.5 | Reduce boilerplate |
| Immutable Models | `freezed` | ^2.5.7 | Code generation for data classes |
| JSON Serialization | `json_annotation` | ^4.9.0 | JSON annotations |
| JSON Serializable | `json_serializable` | ^6.8.0 | Generate JSON code |
| Code Generation | `build_runner` | ^2.4.13 | Run generators |
| Local Database | `hive_ce` | ^2.6.0 | Key-value storage |
| Hive Generator | `hive_ce_generator` | ^1.6.0 | Type adapters |
| Path Provider | `path_provider` | ^2.1.4 | Storage paths |
| Screenshot | `screenshot` | ^3.0.0 | Capture widgets |
| PDF Generation | `pdf` | ^3.11.1 | Create PDFs |
| PDF Printing | `printing` | ^5.13.3 | Print/save PDFs |
| Calendar Export | `icalendar` | ^0.3.0 | .ics files |
| Share Plus | `share_plus` | ^10.0.3 | Share functionality |
| Notifications | `flutter_local_notifications` | ^18.0.1 | Class reminders |
| Timezone | `timezone` | ^0.9.4 | Notification scheduling |
| QR Code | `qr_flutter` | ^4.1.0 | QR code generation |
| UUID | `uuid` | ^4.5.1 | Unique IDs |
| Animations | `animations` | ^2.0.11 | Material transitions |
| Home Widget | `home_widget` | ^0.6.0 | Home screen widgets |
| Color Picker | `flex_color_picker` | ^3.6.0 | Color picker UI |

---

## Domain Models (All Complete ✅)

### Hive Type IDs (0-11)

| ID | Model | Purpose |
|----|-------|---------|
| 0 | `Time` | Time representation (hour, minute) |
| 1 | `Weekday` | Enum for S, M, T, W, Th, F, Sa |
| 2 | `ClassPeriod` | Time slot + room + weekdays |
| 3 | `Teacher` | Instructor info (name, email) |
| 4 | `ClassData` | Complete class information |
| 5 | `TimeSlot` | Sealed union (ClassSlot/BarSlot/EmptySlot) |
| 6 | `ScheduleRow` | Grid row with time + columns |
| 7 | `ScheduleTable` | Complete grid + weekday config |
| 8 | `SavedSchedule` | Persisted schedule with metadata |
| 9 | `ThemePreset` | Color configuration per schedule |
| 10 | `ClassNote` | Notes attached to classes |
| 11 | `NotificationConfig` | Reminder settings |

### Model Files

All models are in `lib/domain/models/`:

1. **`time.dart`** ✅
   - Properties: `hour`, `minute`
   - Methods: `toMinutes()`, `fromMinutes()`, `format(bool is24Hour)`

2. **`weekday.dart`** ✅
   - Enum: S, M, T, W, Th, F, Sa
   - Helper: `fromString()`, `toShortString()`

3. **`class_period.dart`** ✅
   - Properties: `start`, `end`, `room`, `weekdays`
   - Method: `duration()` in minutes

4. **`teacher.dart`** ✅
   - Properties: `familyName`, `givenName`, `emails`
   - Getter: `fullName()`

5. **`class_data.dart`** ✅
   - Properties: `code`, `subject`, `title`, `schedule`, `teacher`

6. **`time_slot.dart`** ✅
   - Sealed union with 3 variants:
     - `ClassSlot` - Contains class data + span
     - `BarSlot` - Lunch/break label + span
     - `EmptySlot` - Just span
   - Common: `rowspan`, `colspan`

7. **`schedule_row.dart`** ✅
   - Properties: `time`, `duration`, `columns`

8. **`schedule_table.dart`** ✅
   - Properties: `rows`, `peWeekdays`, `weekdayConfig`
   - Methods: `getAllClasses()`, `getConflicts()`

9. **`saved_schedule.dart`** ✅
   - Properties: `id` (UUID), `name`, `createdAt`, `table`, `semester`, `themePreset`

10. **`theme_preset.dart`** ✅
    - Properties: `classColors`, `weekdayColors`, `isDarkMode`

11. **`class_note.dart`** ✅
    - Properties: `id`, `classCode`, `content`, `createdAt`, `type`
    - Enum: `NoteType` (homework/exam/general)

12. **`notification_config.dart`** ✅
    - Properties: `enabled`, `minutesBefore`, `activeDays`

13. **`conflict_info.dart`** ✅ (not persisted)
    - Properties: `conflictingClasses`, `startTime`, `endTime`, `weekday`

---

## Domain Services (Next Phase - To Implement)

All services are stateless with static methods in `lib/domain/services/`:

### 1. `parser_service.dart` 🔲
**Purpose:** Parse text input into ClassData objects

**Main Method:**
```dart
static ParseResult parse(String input)
```

**Expected Input Format:**
```
CS101 Computer Science Introduction to Programming
8:00 AM - 9:30 AM Room 204 M W F
DOE, JOHN * john.doe@example.com
3

MATH201 Mathematics Calculus I
10:00 AM - 11:30 AM Room 305 T Th
SMITH, JANE * jane.smith@example.edu
4
```

**Regex Patterns Needed:**
- Class code: `[A-Z]{2,4}\d{3,4}`
- Subject: Capitalized words
- Time: `\d{1,2}:\d{2}\s*[AP]M\s*-\s*\d{1,2}:\d{2}\s*[AP]M`
- Weekdays: `S|M|T|W|Th|F|Sa`
- Room: `Room\s+\d+[A-Z]?`
- Teacher: `LASTNAME, FIRSTNAME * email@domain.com`
- Units: Single digit at end

**Return Type:**
```dart
@freezed
class ParseResult with _$ParseResult {
  const factory ParseResult.success(List<ClassData> classes) = ParseSuccess;
  const factory ParseResult.failure(List<String> errors) = ParseFailure;
}
```

### 2. `arranger_service.dart` 🔲
**Purpose:** Convert ClassData list into ScheduleTable grid

**Main Method:**
```dart
static ScheduleTable arrange(List<ClassData> classes)
```

**Algorithm:**
1. Extract all unique time slots from all classes
2. Sort times chronologically
3. Determine time interval (30 min or 1 hour based on patterns)
4. Create rows for each time slot
5. For each row, create columns for active weekdays
6. Fill cells with ClassSlot/EmptySlot
7. Calculate rowspan based on class duration
8. Mark PE weekdays in weekdayConfig
9. Auto-detect lunch breaks (gaps > 1 hour) and create BarSlots

### 3. `color_service.dart` 🔲
**Purpose:** Assign colors to classes and weekdays

**Methods:**
```dart
static Map<String, ColorSet> assignColors(List<ClassData> classes)
static Color getWeekdayColor(Weekday day)
static ColorSet getColorSet(int index)
```

**Color Palette (Material Design):**
- Red, Pink, Purple, Deep Purple, Indigo, Blue, Cyan, Teal, Green, Light Green

**ColorSet Structure:**
```dart
@freezed
class ColorSet with _$ColorSet {
  const factory ColorSet({
    required Color primary,
    required Color light,
    required Color dark,
    required Color text,
  }) = _ColorSet;
}
```

### 4. `conflict_detection_service.dart` 🔲
**Purpose:** Find overlapping classes

**Main Method:**
```dart
static List<ConflictInfo> detectConflicts(ScheduleTable table)
```

**Algorithm:**
1. For each weekday, collect all classes
2. Compare each pair of classes on the same day
3. Check if time ranges overlap
4. Return ConflictInfo for each overlap

### 5. `export_service.dart` 🔲
**Purpose:** Export schedules to various formats

**Methods:**
```dart
static Future<Uint8List> exportToPNG(ScheduleTable table, DisplayConfig config)
static Future<Uint8List> exportToJPG(ScheduleTable table, DisplayConfig config)
static Future<Uint8List> exportToPDF(ScheduleTable table, DisplayConfig config)
static String exportToICS(ScheduleTable table, String semester)
static String exportToJSON(SavedSchedule schedule)
static SavedSchedule? importFromJSON(String json)
```

**ICS Format Example:**
```ics
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//SchedBuilder//EN
BEGIN:VEVENT
DTSTART:20240901T080000
DTEND:20240901T093000
RRULE:FREQ=WEEKLY;BYDAY=MO,WE,FR
SUMMARY:CS101 - Introduction to Programming
LOCATION:Room 204
DESCRIPTION:Computer Science\nDOE, JOHN
END:VEVENT
END:VCALENDAR
```

### 6. `statistics_service.dart` 🔲
**Purpose:** Calculate schedule statistics

**Methods:**
```dart
static double calculateTotalHours(ScheduleTable table)
static Weekday getBusiestDay(ScheduleTable table)
static Map<Weekday, double> getAverageHoursPerDay(ScheduleTable table)
static int countClasses(ScheduleTable table)
static Map<String, int> getTimeDistribution(ScheduleTable table) // morning/afternoon/evening
```

### 7. `notification_service.dart` 🔲
**Purpose:** Schedule class reminders

**Methods:**
```dart
static Future<void> initialize()
static Future<void> scheduleNotifications(ScheduleTable table, NotificationConfig config)
static Future<void> cancelNotifications(String scheduleId)
static Future<void> rescheduleNotifications(SavedSchedule schedule)
```

### 8. `share_service.dart` 🔲
**Purpose:** Share schedules with QR codes

**Methods:**
```dart
static String generateShareableLink(SavedSchedule schedule) // base64 JSON
static Future<Uint8List> generateQRCode(String link)
static SavedSchedule? parseShareableLink(String link)
```

### 9. `widget_service.dart` 🔲
**Purpose:** Update home screen widget

**Methods:**
```dart
static Future<void> updateHomeWidget(ScheduleTable table, Weekday currentDay)
static List<ClassData> getTodayClasses(ScheduleTable table)
```

---

## Data Layer (To Implement)

### Repository Interface: `lib/domain/repositories/schedule_repository.dart` 🔲

```dart
abstract class ScheduleRepository {
  Future<void> save(SavedSchedule schedule);
  Future<List<SavedSchedule>> getAll();
  Future<SavedSchedule?> getById(String id);
  Future<void> delete(String id);
  Future<void> update(SavedSchedule schedule);
  Future<List<SavedSchedule>> getBySemester(String semester);
}
```

### Repository Implementation: `lib/data/repositories/schedule_repository_impl.dart` 🔲

Uses Hive CE:
```dart
class ScheduleRepositoryImpl implements ScheduleRepository {
  late Box<SavedSchedule> _box;
  
  Future<void> init() async {
    _box = await Hive.openBox<SavedSchedule>('schedules');
  }
  
  @override
  Future<void> save(SavedSchedule schedule) async {
    await _box.put(schedule.id, schedule);
  }
  
  // ... implement other methods
}
```

### Hive Setup: `lib/data/local/hive_setup.dart` 🔲

```dart
Future<void> initHive() async {
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  
  // Register all adapters (generated by build_runner)
  Hive.registerAdapter(TimeAdapter());
  Hive.registerAdapter(WeekdayAdapter());
  Hive.registerAdapter(ClassPeriodAdapter());
  Hive.registerAdapter(TeacherAdapter());
  Hive.registerAdapter(ClassDataAdapter());
  Hive.registerAdapter(TimeSlotAdapter());
  Hive.registerAdapter(ScheduleRowAdapter());
  Hive.registerAdapter(ScheduleTableAdapter());
  Hive.registerAdapter(SavedScheduleAdapter());
  Hive.registerAdapter(ThemePresetAdapter());
  Hive.registerAdapter(ClassNoteAdapter());
  Hive.registerAdapter(NotificationConfigAdapter());
  
  // Open boxes
  await Hive.openBox<SavedSchedule>('schedules');
  await Hive.openBox<ClassNote>('notes');
  await Hive.openBox<ThemePreset>('themes');
  await Hive.openBox<NotificationConfig>('notificationConfig');
}
```

---

## Presentation Layer (To Implement)

### Providers (`lib/presentation/providers/`)

All providers extend `ChangeNotifier`:

1. **`schedule_provider.dart`** 🔲
   - State: `inputText`, `parseResult`, `scheduleTable`, `isLoading`
   - Methods: `updateInput()`, `parseAndArrange()`, `clearSchedule()`

2. **`display_config_provider.dart`** 🔲
   - State: `classColors`, `weekdayColors`, `isDarkMode`, `is24HourFormat`, `customStartTime`, `customEndTime`
   - Methods: `toggleDarkMode()`, `toggle24HourFormat()`, `updateClassColor()`, `setTimeRange()`

3. **`saved_schedules_provider.dart`** 🔲
   - State: `schedules`, `currentScheduleId`, `isLoading`
   - Methods: `loadSchedules()`, `saveSchedule()`, `deleteSchedule()`, `loadScheduleById()`

4. **`notification_provider.dart`** 🔲
   - State: `config`, `permissionGranted`
   - Methods: `updateConfig()`, `requestPermission()`, `scheduleForSchedule()`

5. **`comparison_provider.dart`** 🔲
   - State: `selectedScheduleIds`, `commonFreeTime`
   - Methods: `selectSchedule()`, `calculateCommonFreeTime()`

6. **`theme_preset_provider.dart`** 🔲
   - State: `presets`, `activePreset`
   - Methods: `savePreset()`, `loadPreset()`, `applyPreset()`

7. **`notes_provider.dart`** 🔲
   - State: `notesByClass`
   - Methods: `addNote()`, `updateNote()`, `deleteNote()`

8. **`search_provider.dart`** 🔲
   - State: `query`, `searchResults`
   - Methods: `search()`, `filterByRoom()`, `filterByTeacher()`

### Screens (`lib/presentation/screens/`)

1. **`home_screen.dart`** 🔲
   - Bottom navigation with PageView
   - 5 tabs: Input, Schedule, Saved, Compare, Settings
   - Swipeable navigation
   - Material 3 NavigationBar

2. **`input_screen.dart`** 🔲
   - Text input field
   - Parse button
   - Parsing status widget
   - Import JSON button

3. **`schedule_screen.dart`** 🔲
   - Schedule table widget
   - Conflict indicator
   - Statistics widget
   - Export options
   - Save button
   - Edit mode toggle

4. **`saved_schedules_screen.dart`** 🔲
   - Schedule list (grid/list view toggle)
   - Semester filter
   - Search bar
   - Sort options

5. **`compare_schedules_screen.dart`** 🔲
   - Multi-select schedules
   - Overlay view
   - Free time blocks
   - Export/share comparison

6. **`settings_screen.dart`** 🔲
   - Dark mode toggle
   - Time format toggle
   - Time range picker
   - Notification settings
   - Color picker
   - Home widget config
   - Export/import backup

### Key Widgets (`lib/presentation/widgets/`)

**Input Widgets:**
- `schedule_input_field.dart` - Multiline text field with paste button
- `parsing_status_widget.dart` - Success/error display

**Schedule Display:**
- `schedule_table_widget.dart` - Main grid container
- `schedule_time_cell.dart` - Left column time labels
- `schedule_class_cell.dart` - Class information cell
- `schedule_empty_cell.dart` - Empty slot with dot
- `schedule_bar_cell.dart` - Lunch/break labels

**Class Management:**
- `class_list_widget.dart` - ListView of all classes
- `class_detail_card.dart` - Expanded class info
- `class_notes_widget.dart` - Notes per class

**Export/Share:**
- `export_options_widget.dart` - Multi-format export
- `share_widget.dart` - QR code + shareable link

**Saved Schedules:**
- `saved_schedules_list.dart` - Grid/list view
- `saved_schedule_card.dart` - Schedule summary card

**Analysis:**
- `statistics_widget.dart` - Hours, busiest day, charts
- `conflict_indicator_widget.dart` - Conflict list
- `schedule_comparison_widget.dart` - Multi-schedule overlay

**Settings:**
- `dark_mode_toggle.dart` - SwitchListTile
- `time_format_toggle.dart` - 12hr/24hr switch
- `color_picker_dialog.dart` - FlexColorPicker
- `notification_settings_widget.dart` - Reminder config
- `time_range_picker_widget.dart` - Custom time range
- `theme_preset_selector.dart` - Theme management

---

## Main App Setup

### `lib/main.dart` 🔲

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await initHive();
  
  // Initialize notifications
  await NotificationService.initialize();
  
  // Initialize timezone
  await initializeTimeZones();
  
  // Create repositories
  final scheduleRepo = ScheduleRepositoryImpl();
  await scheduleRepo.init();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScheduleProvider()),
        ChangeNotifierProvider(create: (_) => DisplayConfigProvider()),
        ChangeNotifierProvider(
          create: (_) => SavedSchedulesProvider(repository: scheduleRepo),
        ),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => ComparisonProvider()),
        ChangeNotifierProvider(create: (_) => ThemePresetProvider()),
        ChangeNotifierProvider(create: (_) => NotesProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends HookWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final displayConfig = context.watch<DisplayConfigProvider>();
    
    return MaterialApp(
      title: 'SchedBuilder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: displayConfig.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const HomeScreen(),
    );
  }
}
```

---

## Implementation Phases

### ✅ Phase 1: Project Setup & Domain Models (COMPLETE)
- [x] Update `pubspec.yaml` with all dependencies
- [x] Create all 13 domain models with freezed
- [x] Configure Hive type adapters (typeId 0-11)
- [x] Run build_runner to generate code

### 🔲 Phase 2: Domain Services (NEXT - IN PROGRESS)
- [ ] Create `parser_service.dart` - Text to ClassData
- [ ] Create `arranger_service.dart` - ClassData to ScheduleTable
- [ ] Create `color_service.dart` - Color assignment
- [ ] Create `conflict_detection_service.dart` - Find overlaps
- [ ] Create `export_service.dart` - Export formats (PNG/JPG/PDF/ICS/JSON)
- [ ] Create `statistics_service.dart` - Calculate stats
- [ ] Create `notification_service.dart` - Schedule reminders
- [ ] Create `share_service.dart` - QR codes + links
- [ ] Create `widget_service.dart` - Home widget updates

### 🔲 Phase 3: Data Layer
- [ ] Create `schedule_repository.dart` interface
- [ ] Create `notes_repository.dart` interface
- [ ] Create `schedule_repository_impl.dart` with Hive
- [ ] Create `notes_repository_impl.dart` with Hive
- [ ] Create `hive_setup.dart` initialization

### 🔲 Phase 4: Providers
- [ ] Create all 8 providers (schedule, display config, saved schedules, etc.)
- [ ] Wire up services to providers
- [ ] Test state management flow

### 🔲 Phase 5: Basic UI
- [ ] Create `home_screen.dart` with PageView + BottomNavigation
- [ ] Create `input_screen.dart` with text field
- [ ] Create basic schedule table widget
- [ ] Create schedule cells (time, class, empty, bar)
- [ ] Test parsing and display flow

### 🔲 Phase 6: Persistence & Export
- [ ] Create `saved_schedules_screen.dart`
- [ ] Implement save/load functionality
- [ ] Create export widgets
- [ ] Test export flows (PNG/JPG/PDF/ICS/JSON)

### 🔲 Phase 7: Advanced Features
- [ ] Implement conflict detection UI
- [ ] Create statistics widgets
- [ ] Implement search functionality
- [ ] Create notes system
- [ ] Create comparison screen

### 🔲 Phase 8: Customization
- [ ] Implement theme presets
- [ ] Create color picker
- [ ] Create settings screen
- [ ] Test theme persistence per schedule

### 🔲 Phase 9: Social & Notifications
- [ ] Implement share service with QR codes
- [ ] Setup notifications
- [ ] Create notification settings
- [ ] Test notification scheduling

### 🔲 Phase 10: Polish
- [ ] Add animations
- [ ] Implement accessibility features
- [ ] Write tests
- [ ] Fix bugs
- [ ] Optimize performance

---

## Sample Input Format

Users will paste schedule text like this:

```
CS101 Computer Science Introduction to Programming
8:00 AM - 9:30 AM Room 204 M W F
DOE, JOHN * john.doe@example.com
3

MATH201 Mathematics Calculus I
10:00 AM - 11:30 AM Room 305 T Th
SMITH, JANE * jane.smith@example.edu
4

ENG102 English Composition II
1:00 PM - 2:30 PM Room 101 M W
BROWN, ALICE * alice.brown@example.com
3
```

Parser will extract:
- Class code (CS101)
- Subject (Computer Science)
- Title (Introduction to Programming)
- Time range (8:00 AM - 9:30 AM)
- Room (Room 204)
- Weekdays (M W F → Monday, Wednesday, Friday)
- Teacher (DOE, JOHN with email)
- Units (3)

---

## Key Features Summary

### ✅ Included Features
- Text paste input parsing
- Visual schedule table
- Conflict detection with red highlights
- Customizable time range
- Break/lunch auto-detection
- Edit mode (tap class to edit/delete)
- Quick semester switch
- Save individual schedules
- Theme presets per schedule
- Calendar export (.ics)
- Class reminders (notifications)
- Custom color picker
- Statistics (total hours, busiest day)
- Search (room/teacher)
- Share with QR code
- Home screen widget
- Find common free time
- Notes per class
- Multi-format export (PNG/JPG/PDF/ICS/JSON)
- JSON import
- Material Design 3
- Animations
- Full accessibility
- Bottom navigation with PageView
- 12hr/24hr format toggle
- Offline-first

### ❌ Not Included
- Cloud sync
- File import (txt/csv)
- Manual entry form
- Camera OCR
- School API import

---

## Testing Strategy

### Unit Tests
- Test `ParserService.parse()` with various inputs
- Test `ArrangerService.arrange()` with edge cases
- Test `ConflictDetectionService.detectConflicts()`
- Test all model methods

### Widget Tests
- Test input field updates provider
- Test schedule table renders correctly
- Test provider state changes trigger UI updates

### Integration Tests
- Full flow: paste → parse → arrange → save → load
- Export flow for each format
- Notification scheduling

### Manual Testing Checklist
- [ ] Paste sample schedule text
- [ ] Verify parsing success
- [ ] Check schedule table display
- [ ] Test conflict detection
- [ ] Save schedule
- [ ] Load schedule after restart
- [ ] Export to all formats
- [ ] Toggle dark mode
- [ ] Toggle time format
- [ ] Test accessibility with screen reader

---

## Next Immediate Steps

1. **Start Phase 2:** Implement `parser_service.dart`
   - Write regex patterns for class code, subject, time, weekdays, room, teacher
   - Implement `parse()` method
   - Return `ParseResult.success()` or `ParseResult.failure()`
   - Write unit tests

2. **Then:** Implement `arranger_service.dart`
   - Extract unique time slots
   - Sort chronologically
   - Build grid structure
   - Fill cells with ClassSlot/EmptySlot
   - Calculate rowspan
   - Auto-detect lunch breaks

3. **Then:** Implement `color_service.dart`
   - Define 10-color palette
   - Rotate colors for subjects
   - Create ColorSet for each subject

4. **Test:** Create simple test harness to verify parser → arranger → color flow works

---

## Important Notes

- **All models use freezed** - Always use `copyWith()` for modifications
- **Hive type IDs 0-11** - Don't change these after release
- **Services are stateless** - All methods are static
- **Providers manage state** - Use ChangeNotifier pattern
- **Material 3** - Use NavigationBar, not BottomNavigationBar
- **Hooks** - Use flutter_hooks in all widgets to reduce boilerplate
- **Offline-first** - All data stored locally, no cloud sync
- **Clean architecture** - Domain layer has no Flutter dependencies

---

## File Structure

```
lib/
├── main.dart
├── domain/
│   ├── models/
│   │   ├── time.dart ✅
│   │   ├── weekday.dart ✅
│   │   ├── class_period.dart ✅
│   │   ├── teacher.dart ✅
│   │   ├── class_data.dart ✅
│   │   ├── time_slot.dart ✅
│   │   ├── schedule_row.dart ✅
│   │   ├── schedule_table.dart ✅
│   │   ├── saved_schedule.dart ✅
│   │   ├── theme_preset.dart ✅
│   │   ├── class_note.dart ✅
│   │   ├── notification_config.dart ✅
│   │   └── conflict_info.dart ✅
│   ├── services/
│   │   ├── parser_service.dart 🔲
│   │   ├── arranger_service.dart 🔲
│   │   ├── color_service.dart 🔲
│   │   ├── conflict_detection_service.dart 🔲
│   │   ├── export_service.dart 🔲
│   │   ├── statistics_service.dart 🔲
│   │   ├── notification_service.dart 🔲
│   │   ├── share_service.dart 🔲
│   │   └── widget_service.dart 🔲
│   └── repositories/
│       ├── schedule_repository.dart 🔲
│       └── notes_repository.dart 🔲
├── data/
│   ├── repositories/
│   │   ├── schedule_repository_impl.dart 🔲
│   │   └── notes_repository_impl.dart 🔲
│   └── local/
│       └── hive_setup.dart 🔲
└── presentation/
    ├── providers/
    │   ├── schedule_provider.dart 🔲
    │   ├── display_config_provider.dart 🔲
    │   ├── saved_schedules_provider.dart 🔲
    │   ├── notification_provider.dart 🔲
    │   ├── comparison_provider.dart 🔲
    │   ├── theme_preset_provider.dart 🔲
    │   ├── notes_provider.dart 🔲
    │   └── search_provider.dart 🔲
    ├── screens/
    │   ├── home_screen.dart 🔲
    │   ├── input_screen.dart 🔲
    │   ├── schedule_screen.dart 🔲
    │   ├── saved_schedules_screen.dart 🔲
    │   ├── compare_schedules_screen.dart 🔲
    │   └── settings_screen.dart 🔲
    └── widgets/
        ├── [23 widget files to be created] 🔲
```

---

## Commands Reference

### Code Generation
```bash
# Generate freezed + Hive adapters
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (auto-regenerate on save)
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Running App
```bash
# Run on connected device
flutter run

# Run on specific device
flutter run -d chrome  # Web
flutter run -d android # Android
flutter run -d ios     # iOS
```

### Testing
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/domain/services/parser_service_test.dart

# Run with coverage
flutter test --coverage
```

---

## Contact & Resources

- **Flutter Docs:** https://docs.flutter.dev
- **Freezed Package:** https://pub.dev/packages/freezed
- **Hive CE:** https://pub.dev/packages/hive_ce
- **Provider:** https://pub.dev/packages/provider
- **Material 3:** https://m3.material.io

---

**Last Updated:** Phase 1 Complete - Ready for Phase 2 (Domain Services)
