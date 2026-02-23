# SchedBuilder - Flutter Schedule Builder App

## Project Overview

**SchedBuilder** is a comprehensive Flutter application designed to help students parse, visualize, manage, and share their class schedules. The app uses clean architecture principles with offline-first data persistence.

### Core Purpose
Students receive schedules in various text formats (email, PDF, copy-paste). SchedBuilder transforms this text into:
- **Visual weekly grid** - Easy-to-read table format
- **Saved schedules** - Multiple schedules with custom themes
- **Exportable formats** - PNG, JPG, PDF, iCalendar (.ics), JSON
- **Smart features** - Conflict detection, statistics, reminders, sharing

---

## Architecture

### Three-Layer Clean Architecture

```
┌─────────────────────────────────────────────────────────┐
│              PRESENTATION LAYER                         │
│         (Flutter Widgets + State Management)            │
│                                                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │   Screens    │  │   Widgets    │  │  Providers   │  │
│  │  (6 files)   │  │  (23 files)  │  │  (8 files)   │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
│         │                   │                 │         │
│         └───────────────────┴─────────────────┘         │
└─────────────────────────┬───────────────────────────────┘
                          │
┌─────────────────────────▼───────────────────────────────┐
│                  DOMAIN LAYER                           │
│             (Pure Dart - No Flutter)                    │
│                                                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │    Models    │  │   Services   │  │ Repositories │  │
│  │  (13 files)  │  │  (9 files)   │  │ (interfaces) │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
│         │                   │                 │         │
│         └───────────────────┴─────────────────┘         │
└─────────────────────────┬───────────────────────────────┘
                          │
┌─────────────────────────▼───────────────────────────────┐
│                   DATA LAYER                            │
│              (Hive CE Persistence)                      │
│                                                          │
│  ┌──────────────┐  ┌──────────────┐                     │
│  │  Repository  │  │  Hive Setup  │                     │
│  │     Impl     │  │  & Adapters  │                     │
│  └──────────────┘  └──────────────┘                     │
└─────────────────────────────────────────────────────────┘
```

### Technology Stack

| Purpose | Package | Version | Why? |
|---------|---------|---------|------|
| State Management | `provider` | ^6.1.2 | Simple, reliable ChangeNotifier pattern |
| Hooks | `flutter_hooks` | ^0.20.5 | Reduce boilerplate in stateful widgets |
| Immutable Models | `freezed` | ^2.5.7 | Code generation for data classes |
| JSON Serialization | `json_serializable` | ^6.8.0 | JSON import/export |
| Local Database | `hive_ce` | ^2.6.0 | **Lightweight, fast, type-safe persistence** |
| Hive Code Gen | `hive_ce_generator` | ^1.6.0 | Generate type adapters |
| Screenshots | `screenshot` | ^3.0.0 | Capture schedule as image |
| PDF Export | `pdf` + `printing` | ^3.11.1 + ^5.13.3 | Generate PDF documents |
| Calendar Export | `icalendar` | ^0.3.0 | .ics format for Google/Apple Calendar |
| Notifications | `flutter_local_notifications` | ^18.0.1 | Class reminders |
| Sharing | `share_plus` | ^10.0.3 | Cross-platform sharing |
| QR Codes | `qr_flutter` | ^4.1.0 | Share schedules via QR |
| Home Widget | `home_widget` | ^0.6.0 | Today's schedule widget |
| Color Picker | `flex_color_picker` | ^3.6.0 | Theme customization |

---

## Project Structure

```
lib/
├── main.dart                           # App entry point with MultiProvider setup
│
├── domain/                             # Pure Dart business logic
│   ├── models/                         # Data models (freezed + hive_ce)
│   │   ├── time.dart                   # Time representation (HH:MM)
│   │   ├── weekday.dart                # Enum: S, M, T, W, Th, F, Sa
│   │   ├── class_period.dart           # Time slot + room + weekdays
│   │   ├── teacher.dart                # Instructor info
│   │   ├── class_data.dart             # Complete class info
│   │   ├── time_slot.dart              # Sealed union: ClassSlot | BarSlot | EmptySlot
│   │   ├── schedule_row.dart           # Grid row (time + columns)
│   │   ├── schedule_table.dart         # Complete weekly grid
│   │   ├── saved_schedule.dart         # Persisted schedule with theme
│   │   ├── theme_preset.dart           # Color theme configuration
│   │   ├── class_note.dart             # Notes per class
│   │   ├── notification_config.dart    # Reminder settings
│   │   └── conflict_info.dart          # Detected overlapping classes
│   │
│   ├── services/                       # Stateless business logic
│   │   ├── parser_service.dart         # Text → ClassData (regex parsing)
│   │   ├── arranger_service.dart       # ClassData → ScheduleTable (grid layout)
│   │   ├── color_service.dart          # Color assignment (10-color palette)
│   │   ├── conflict_detection_service.dart  # Find overlapping classes
│   │   ├── export_service.dart         # PNG/JPG/PDF/ICS/JSON export
│   │   ├── statistics_service.dart     # Total hours, busiest day, etc.
│   │   ├── notification_service.dart   # Schedule class reminders
│   │   ├── share_service.dart          # Generate shareable links + QR codes
│   │   └── widget_service.dart         # Update home screen widget
│   │
│   └── repositories/                   # Interfaces (implemented in data layer)
│       ├── schedule_repository.dart    # CRUD for saved schedules
│       └── notes_repository.dart       # CRUD for class notes
│
├── data/                               # Data persistence layer
│   ├── repositories/                   # Repository implementations
│   │   ├── schedule_repository_impl.dart  # Hive CE implementation
│   │   └── notes_repository_impl.dart     # Hive CE implementation
│   │
│   └── local/                          # Local storage setup
│       └── hive_setup.dart             # Initialize Hive CE, register adapters
│
└── presentation/                       # Flutter UI layer
    ├── providers/                      # ChangeNotifier state management
    │   ├── schedule_provider.dart      # Current schedule state
    │   ├── display_config_provider.dart # UI config (dark mode, colors, time format)
    │   ├── saved_schedules_provider.dart # Saved schedules list
    │   ├── notification_provider.dart   # Reminder settings
    │   ├── comparison_provider.dart     # Multi-schedule comparison
    │   ├── theme_preset_provider.dart   # Theme management
    │   ├── notes_provider.dart          # Class notes
    │   └── search_provider.dart         # Search/filter schedules
    │
    ├── screens/                        # Full-screen pages (5 tabs)
    │   ├── home_screen.dart            # PageView + BottomNavigationBar
    │   ├── input_screen.dart           # Text input + parsing
    │   ├── schedule_screen.dart        # Schedule table + export
    │   ├── saved_schedules_screen.dart # List of saved schedules
    │   ├── compare_schedules_screen.dart # Find common free time
    │   └── settings_screen.dart        # App settings
    │
    └── widgets/                        # Reusable components (23 files)
        ├── Input widgets (2)
        ├── Schedule display widgets (5)
        ├── Class info widgets (3)
        ├── Export widgets (2)
        ├── Saved schedules widgets (2)
        ├── Comparison widgets (1)
        ├── Statistics widgets (2)
        └── Settings widgets (6)
```

---

## Key Features

### ✅ Implemented Features

#### High Priority
- ✅ **Conflict Detection** - Red borders on overlapping classes
- ✅ **Customizable Time Range** - User sets schedule start/end times
- ✅ **Break/Lunch Detection** - Auto-detect and highlight breaks
- ✅ **Edit Mode** - Tap to edit/delete classes
- ✅ **Semester Switching** - Dropdown for Fall/Spring/Summer
- ✅ **Individual Schedule Saves** - Multiple schedules stored locally
- ✅ **Theme Presets per Schedule** - Each schedule has custom colors

#### Medium Priority
- ✅ **Calendar Export (.ics)** - Works with Google/Apple Calendar
- ✅ **Class Reminders** - Notifications before class starts
- ✅ **Custom Color Picker** - Per-subject color customization
- ✅ **Statistics** - Total hours, busiest day, time distribution
- ✅ **Search** - Filter by room, teacher, subject

#### Nice-to-Have
- ✅ **Share with Friends** - QR codes + shareable links
- ✅ **Home Screen Widget** - Today's schedule on home screen
- ✅ **Find Common Free Time** - Compare multiple schedules
- ✅ **Notes per Class** - Homework/exam notes

#### Export Formats
- ✅ **PNG Export** - High-quality images
- ✅ **JPG Export** - Compressed images
- ✅ **PDF Export** - Printable documents
- ✅ **Calendar Export (.ics)** - Import to calendar apps
- ✅ **JSON Export** - Backup/restore schedules

#### UI/UX
- ✅ **Material Design 3** - Modern Flutter design
- ✅ **Custom Elements** - Hybrid Material 3 + custom
- ✅ **Animations** - Smooth transitions
- ✅ **Full Accessibility** - Screen readers, high contrast, font scaling
- ✅ **PageView Navigation** - Swipeable tabs with bottom nav

#### Platforms
- ✅ **Android** - Full support
- ✅ **iOS** - Full support
- ✅ **Web** - Browser support
- ✅ **Desktop** - Windows, macOS, Linux

### ❌ Not Implemented (Future)
- ❌ Cloud sync (offline-first for now)
- ❌ Multi-user/family schedules
- ❌ School calendar integration
- ❌ GPA calculator
- ❌ File import (txt/csv)
- ❌ Manual class entry form
- ❌ Camera OCR

---

## Data Flow

### 1. Schedule Creation Flow
```
User Input (Text)
    ↓
ParserService.parse()
    ↓
List<ClassData>
    ↓
ArrangerService.arrange()
    ↓
ScheduleTable
    ↓
ScheduleProvider (state)
    ↓
ScheduleTableWidget (UI)
```

### 2. Save Schedule Flow
```
ScheduleTable + Theme
    ↓
SavedSchedule (with UUID)
    ↓
ScheduleRepository.save()
    ↓
Hive CE Box<SavedSchedule>
    ↓
Local Storage (persistent)
```

### 3. Export Flow
```
ScheduleTable + DisplayConfig
    ↓
ExportService.exportToPNG/PDF/ICS/JSON()
    ↓
Uint8List / String
    ↓
Share/Save to Gallery
```

---

## Hive CE Usage

### Why Hive CE?
- **Community Edition** - Actively maintained fork of original Hive
- **Type-safe** - `Box<T>` instead of dynamic boxes
- **Faster** - Performance improvements
- **Cleaner API** - Better developer experience
- **Null-safety** - Full null-safety support

### Hive CE Boxes

| Box Name | Type | Purpose |
|----------|------|---------|
| `schedules` | `Box<SavedSchedule>` | Store saved schedules |
| `notes` | `Box<ClassNote>` | Store class notes |
| `theme_presets` | `Box<ThemePreset>` | Store color themes |
| `notification_config` | `Box<NotificationConfig>` | Store reminder settings |

### Type Adapters (Generated by hive_ce_generator)

```dart
@HiveType(typeId: 0)
class Time {
  @HiveField(0)
  final int hour;
  
  @HiveField(1)
  final int minute;
}

// build_runner generates TimeAdapter
```

**Type IDs:**
- 0: Time
- 1: Weekday (enum)
- 2: ClassPeriod
- 3: Teacher
- 4: ClassData
- 5: TimeSlot (sealed union)
- 6: ScheduleRow
- 7: ScheduleTable
- 8: SavedSchedule
- 9: ThemePreset
- 10: ClassNote
- 11: NotificationConfig

---

## State Management with Provider

### Provider Pattern

```dart
// In main.dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => ScheduleProvider()),
    ChangeNotifierProvider(create: (_) => DisplayConfigProvider()),
    ChangeNotifierProvider(create: (_) => SavedSchedulesProvider(...)),
    // ... more providers
  ],
  child: MyApp(),
)

// In widgets
class SomeWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // Watch for changes
    final schedule = context.watch<ScheduleProvider>().scheduleTable;
    
    // Read once (no rebuild)
    final config = context.read<DisplayConfigProvider>();
    
    // Select specific field
    final isDark = context.select<DisplayConfigProvider, bool>(
      (p) => p.isDarkMode,
    );
    
    return ...;
  }
}
```

### Key Providers

1. **ScheduleProvider**
   - Current schedule being edited
   - Parsing status
   - Loading states

2. **DisplayConfigProvider**
   - Dark mode
   - Time format (12hr/24hr)
   - Class colors
   - Weekday colors
   - Time range

3. **SavedSchedulesProvider**
   - List of saved schedules
   - CRUD operations
   - Semester filtering

4. **ThemePresetProvider**
   - Saved color themes
   - Apply theme to schedule

---

## Navigation Pattern

### PageView + BottomNavigationBar

```dart
class HomeScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final currentPage = useState(0);
    
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (index) => currentPage.value = index,
        children: [
          InputScreen(),        // Tab 0
          ScheduleScreen(),     // Tab 1
          SavedSchedulesScreen(), // Tab 2
          CompareSchedulesScreen(), // Tab 3
          SettingsScreen(),     // Tab 4
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPage.value,
        onDestinationSelected: (index) {
          currentPage.value = index;
          pageController.animateToPage(index, ...);
        },
        destinations: [...],
      ),
    );
  }
}
```

**Benefits:**
- Swipeable tabs (great UX)
- Synced state between PageView and NavigationBar
- Material 3 NavigationBar component
- Smooth animations

---

## Schedule Parsing Format

### Input Text Format

```
CODE SUBJECT TITLE * TIME ROOM DAYS * TEACHER EMAIL UNITS
```

**Example:**
```
CS101 Computer Science Introduction to Programming * 8:00 AM - 9:30 AM Room 204 M W F * DOE, JOHN john.doe@example.com 3
MATH201 Mathematics Calculus I * 10:00 AM - 11:30 AM Room 305 T Th * SMITH, JANE jane.smith@example.edu 4
```

### Regex Patterns (ParserService)

- **Class Code:** `[A-Z]+\d+`
- **Time:** `\d{1,2}:\d{2}\s*(AM|PM)`
- **Weekdays:** `(M|T|W|Th|F|S|Sa)`
- **Room:** `Room\s+\d+`
- **Teacher:** `[A-Z]+,\s*[A-Z]+`
- **Email:** `[\w\.-]+@[\w\.-]+`

---

## Grid Layout Algorithm (ArrangerService)

### Step 1: Extract Unique Times
```dart
Set<Time> times = {};
for (class in classes) {
  times.add(class.period.start);
  times.add(class.period.end);
}
times = times.sorted();
```

### Step 2: Create Grid Structure
```dart
List<ScheduleRow> rows = [];
for (time in times) {
  rows.add(ScheduleRow(
    time: time,
    duration: calculateDuration(time, nextTime),
    columns: List.filled(7, EmptySlot()), // 7 weekdays
  ));
}
```

### Step 3: Fill Grid with Classes
```dart
for (class in classes) {
  for (weekday in class.period.weekdays) {
    int rowIndex = findRowIndex(class.period.start);
    int rowspan = calculateRowspan(class.period.start, class.period.end);
    
    rows[rowIndex].columns[weekday.index] = ClassSlot(
      classData: class,
      rowspan: rowspan,
      colspan: 1,
      duration: class.period.duration,
    );
  }
}
```

---

## Conflict Detection Algorithm

```dart
List<ConflictInfo> detectConflicts(ScheduleTable table) {
  final conflicts = <ConflictInfo>[];
  
  for (final weekday in Weekday.values) {
    final classesOnDay = table.getClassesForWeekday(weekday);
    
    // Compare all pairs of classes
    for (var i = 0; i < classesOnDay.length; i++) {
      for (var j = i + 1; j < classesOnDay.length; j++) {
        final class1 = classesOnDay[i];
        final class2 = classesOnDay[j];
        
        if (timeRangesOverlap(class1.period, class2.period)) {
          conflicts.add(ConflictInfo(
            conflictingClasses: [class1, class2],
            startTime: max(class1.period.start, class2.period.start),
            endTime: min(class1.period.end, class2.period.end),
            weekday: weekday,
          ));
        }
      }
    }
  }
  
  return conflicts;
}
```

**UI Indication:**
- Red border on conflicting cells
- Conflict badge in schedule header
- Expandable conflict list

---

## Export Formats

### 1. PNG/JPG Export
```dart
// Using screenshot package
final controller = ScreenshotController();
final imageBytes = await controller.captureFromWidget(
  ScheduleTableWidget(table: scheduleTable),
  pixelRatio: 3.0,
);

// Save to gallery
await ImageGallerySaver.saveImage(imageBytes);
```

### 2. PDF Export
```dart
// Using pdf package
final pdf = pw.Document();
pdf.addPage(
  pw.Page(
    build: (context) => pw.Table(
      children: scheduleTable.rows.map((row) => 
        pw.TableRow(children: ...)
      ).toList(),
    ),
  ),
);

final bytes = await pdf.save();
await Printing.sharePdf(bytes: bytes, filename: 'schedule.pdf');
```

### 3. iCalendar (.ics) Export
```dart
// Using icalendar package
final calendar = ICalendar();

for (final classData in scheduleTable.getAllClasses()) {
  calendar.addEvent(IEvent(
    uid: '${classData.code}@schedbuilder',
    dtStart: combineDateTime(classData.period.start),
    dtEnd: combineDateTime(classData.period.end),
    summary: '${classData.code} - ${classData.subject}',
    location: classData.period.room,
    description: 'Teacher: ${classData.teacher?.fullName}',
    rrule: RecurrenceRule(
      frequency: Frequency.weekly,
      byWeekDay: classData.period.weekdays.map((d) => d.toICalDay()),
    ),
  ));
}

final icsString = calendar.serialize();
```

### 4. JSON Export
```dart
// Using json_serializable
final json = jsonEncode(savedSchedule.toJson());

// Import
final schedule = SavedSchedule.fromJson(jsonDecode(json));
```

---

## Notifications System

### Setup (flutter_local_notifications)

```dart
// Initialize in main.dart
await NotificationService.initialize();

// Request permission
bool granted = await NotificationService.requestPermission();
```

### Schedule Recurring Notifications

```dart
void scheduleNotifications(
  SavedSchedule schedule,
  NotificationConfig config,
) async {
  for (final classData in schedule.table.getAllClasses()) {
    for (final period in classData.schedule) {
      for (final weekday in period.weekdays) {
        if (config.activeDays.contains(weekday)) {
          await flutterLocalNotificationsPlugin.zonedSchedule(
            generateId(classData.code, weekday),
            '${classData.code} starts soon',
            '${classData.subject} in ${period.room}',
            _nextInstanceOfWeekday(
              weekday,
              period.start.subtract(
                Duration(minutes: config.minutesBefore),
              ),
            ),
            notificationDetails,
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            uiLocalNotificationDateInterpretation: ...,
            matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
          );
        }
      }
    }
  }
}
```

---

## Sharing System

### Generate Shareable Link

```dart
String generateShareableLink(SavedSchedule schedule) {
  final json = jsonEncode(schedule.toJson());
  final base64 = base64Encode(utf8.encode(json));
  return 'schedbuilder://import?data=$base64';
}
```

### Generate QR Code

```dart
// Using qr_flutter
QrImageView(
  data: shareableLink,
  version: QrVersions.auto,
  size: 200.0,
)
```

### Parse Shared Link

```dart
SavedSchedule? parseShareableLink(String link) {
  final uri = Uri.parse(link);
  if (uri.scheme != 'schedbuilder' || uri.host != 'import') {
    return null;
  }
  
  final base64Data = uri.queryParameters['data'];
  if (base64Data == null) return null;
  
  final json = utf8.decode(base64Decode(base64Data));
  return SavedSchedule.fromJson(jsonDecode(json));
}
```

---

## Home Screen Widget

### Android (Kotlin)

```kotlin
// ScheduleWidgetProvider.kt
class ScheduleWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(...) {
        // Read today's schedule from shared preferences
        val todayClasses = HomeWidget.getData(context, "today_classes")
        
        // Update widget layout
        val views = RemoteViews(context.packageName, R.layout.schedule_widget)
        views.setTextViewText(R.id.widget_text, todayClasses)
        
        appWidgetManager.updateAppWidget(appWidgetId, views)
    }
}
```

### iOS (Swift)

```swift
// SchedBuilderWidget.swift
@main
struct SchedBuilderWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "SchedBuilderWidget", provider: Provider()) { entry in
            SchedBuilderWidgetEntryView(entry: entry)
        }
    }
}
```

### Flutter Side

```dart
// Update widget from Flutter
await HomeWidget.saveWidgetData<String>(
  'today_classes',
  getTodayClassesText(),
);
await HomeWidget.updateWidget(
  androidName: 'ScheduleWidgetProvider',
  iOSName: 'SchedBuilderWidget',
);
```

---

## Code Generation Commands

### Build Runner (Freezed + Hive CE + JSON)

```bash
# Generate all code
flutter pub run build_runner build --delete-conflicting-outputs

# Watch for changes
flutter pub run build_runner watch --delete-conflicting-outputs

# Clean generated files
flutter pub run build_runner clean
```

### Generated Files
- `*.freezed.dart` - Freezed models
- `*.g.dart` - Hive CE adapters + JSON serialization

---

## Testing Strategy

### Unit Tests (`test/domain/`)

```dart
// Test parser
test('ParserService parses valid schedule text', () {
  final result = ParserService.parse(validScheduleText);
  expect(result.isSuccess, true);
  expect(result.classes.length, 2);
});

// Test arranger
test('ArrangerService creates valid grid', () {
  final table = ArrangerService.arrange(classes);
  expect(table.rows.isNotEmpty, true);
});

// Test conflict detection
test('ConflictDetectionService finds overlaps', () {
  final conflicts = ConflictDetectionService.detectConflicts(table);
  expect(conflicts.length, 1);
});
```

### Widget Tests (`test/presentation/`)

```dart
testWidgets('ScheduleTableWidget displays schedule', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: ScheduleTableWidget(table: mockScheduleTable),
    ),
  );
  
  expect(find.text('CS101'), findsOneWidget);
  expect(find.text('8:00 AM'), findsWidgets);
});
```

### Integration Tests (`integration_test/`)

```dart
testWidgets('Full schedule creation flow', (tester) async {
  // 1. Open app
  await tester.pumpWidget(MyApp());
  
  // 2. Navigate to input screen
  await tester.tap(find.byIcon(Icons.edit));
  await tester.pumpAndSettle();
  
  // 3. Enter schedule text
  await tester.enterText(find.byType(TextField), sampleSchedule);
  
  // 4. Parse
  await tester.tap(find.text('Parse'));
  await tester.pumpAndSettle();
  
  // 5. Verify schedule appears
  expect(find.text('CS101'), findsOneWidget);
  
  // 6. Save schedule
  await tester.tap(find.byIcon(Icons.save));
  await tester.pumpAndSettle();
  
  // 7. Verify in saved list
  await tester.tap(find.text('Saved'));
  expect(find.text('Fall 2024'), findsOneWidget);
});
```

---

## Development Guidelines

### Code Style

1. **Always use flutter_hooks** for stateful widgets
2. **Always use context.watch/read** instead of Provider.of
3. **Keep widgets small** - Extract subwidgets when > 100 lines
4. **Keep services stateless** - All logic in pure functions
5. **Use freezed for models** - Immutable data classes
6. **Type-safe Hive CE boxes** - `Box<T>` not `Box<dynamic>`

### File Naming

- Models: `snake_case.dart`
- Widgets: `snake_case.dart`
- Screens: `snake_case_screen.dart`
- Providers: `snake_case_provider.dart`
- Services: `snake_case_service.dart`

### Import Order

```dart
// 1. Dart imports
import 'dart:async';
import 'dart:convert';

// 2. Flutter imports
import 'package:flutter/material.dart';

// 3. Package imports
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// 4. Local imports
import '../domain/models/schedule_table.dart';
import '../presentation/providers/schedule_provider.dart';
```

---

## Common Tasks for Future Development

### Adding a New Model

1. Create model file in `lib/domain/models/`
2. Add `@HiveType(typeId: X)` and `@HiveField(N)` annotations
3. Add `@freezed` annotation
4. Run `flutter pub run build_runner build`
5. Register adapter in `hive_setup.dart`

### Adding a New Service

1. Create service file in `lib/domain/services/`
2. Make all methods static
3. Keep it pure (no state, no side effects)
4. Write unit tests

### Adding a New Screen

1. Create screen file in `lib/presentation/screens/`
2. Extend `HookWidget`
3. Add to `PageView` in `home_screen.dart`
4. Add tab to `NavigationBar`

### Adding a New Widget

1. Create widget file in `lib/presentation/widgets/`
2. Extend `HookWidget`
3. Use `context.watch` for reactive state
4. Keep it focused (single responsibility)

---

## Troubleshooting

### Common Issues

**Issue: Build runner fails**
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

**Issue: Hive box not found**
```dart
// Ensure Hive is initialized before runApp()
await initHive();
runApp(...);
```

**Issue: Notifications not showing**
```dart
// Check permissions
bool granted = await NotificationService.requestPermission();
if (!granted) {
  // Show permission dialog
}
```

**Issue: Widget not updating**
```dart
// Use context.watch, not context.read
final schedule = context.watch<ScheduleProvider>().scheduleTable;

// Or call notifyListeners() in provider
notifyListeners();
```

---

## Performance Optimization

### Lazy Loading

```dart
// Use ListView.builder for long lists
ListView.builder(
  itemCount: schedules.length,
  itemBuilder: (context, index) => ScheduleCard(schedules[index]),
)
```

### RepaintBoundary

```dart
// Isolate expensive widgets
RepaintBoundary(
  child: ScheduleTableWidget(table: table),
)
```

### Const Constructors

```dart
// Use const where possible
const Text('Schedule')
const SizedBox(height: 16)
```

### Image Caching

```dart
// Cache generated images
final cachedImage = await ImageCache.get(scheduleId);
if (cachedImage != null) return cachedImage;
```

---

## Accessibility Features

### Semantic Labels

```dart
Semantics(
  label: 'Schedule for ${classData.code}',
  child: ScheduleClassCell(classData),
)
```

### Screen Reader Support

```dart
// Use meaningful labels
IconButton(
  icon: Icon(Icons.edit),
  tooltip: 'Edit schedule',
  onPressed: () => ...,
)
```

### High Contrast Mode

```dart
final isHighContrast = MediaQuery.of(context).highContrast;
if (isHighContrast) {
  // Use high contrast colors
}
```

### Font Scaling

```dart
Text(
  'Class Title',
  style: TextStyle(
    fontSize: 16 * MediaQuery.of(context).textScaleFactor,
  ),
)
```

---

## Deployment Checklist

### Pre-Release

- [ ] All unit tests pass
- [ ] All widget tests pass
- [ ] All integration tests pass
- [ ] No linter errors
- [ ] App icons created (all sizes)
- [ ] Splash screen implemented
- [ ] App name finalized
- [ ] Package name set
- [ ] Version number set in pubspec.yaml

### Android

- [ ] `android/app/build.gradle` configured
- [ ] Signing key generated
- [ ] ProGuard rules set
- [ ] Permissions declared in AndroidManifest.xml
- [ ] Build APK/AAB: `flutter build apk --release`

### iOS

- [ ] Bundle ID set in Xcode
- [ ] Signing & Capabilities configured
- [ ] Info.plist permissions set
- [ ] Build IPA: `flutter build ios --release`

### Web

- [ ] `web/index.html` configured
- [ ] Favicon set
- [ ] Meta tags added
- [ ] Build: `flutter build web --release`

### Desktop

- [ ] Windows: `flutter build windows --release`
- [ ] macOS: `flutter build macos --release`
- [ ] Linux: `flutter build linux --release`

---

## Future Enhancements (Not Implemented)

1. **Cloud Sync** - Firebase/Supabase backend
2. **Multi-user** - Family schedule management
3. **School Integration** - API imports from school systems
4. **GPA Calculator** - Link grades to classes
5. **Assignment Tracker** - Homework/exam tracker
6. **OCR** - Scan paper schedules with camera
7. **Manual Entry** - Form-based class entry
8. **CSV/TXT Import** - File-based imports

---

## Resources

- **Flutter Docs:** https://docs.flutter.dev
- **Provider Docs:** https://pub.dev/packages/provider
- **Hive CE Docs:** https://pub.dev/packages/hive_ce
- **Freezed Docs:** https://pub.dev/packages/freezed
- **Material Design 3:** https://m3.material.io

---

## Contact & Support

For questions about this codebase, refer to:
1. This CLAUDE.md file
2. Inline code comments
3. README.md for user-facing documentation
4. Implementation plan at `.claude/plans/`

**Architecture Philosophy:** Clean, testable, maintainable. Keep business logic pure, UI reactive, and data persistent.