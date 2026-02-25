# SchedBuilder - Claude Development Notes

## Project Overview
A Flutter schedule builder app that parses text schedules, visualizes them in a weekly grid, and provides features like conflict detection, statistics, and export capabilities.

## Current Status (2026-02-23)

### ✅ Completed Features
- **Clean Architecture**: Domain, Data, and Presentation layers properly separated
- **Schedule parsing** from text format with comprehensive error handling
- **Weekly grid visualization** with color-coded classes
- **Hive CE persistence** for save/load schedules (migrated from Freezed to simple classes with @GenerateAdapters)
- **Export to PNG, PDF, Calendar (.ics), and JSON** with full UI integration
- **Statistics widget** with charts and visualizations
- **Conflict detection** with detailed UI highlighting overlapping classes
- **Bottom navigation** with Input, Saved, and Settings screens
- **Dark mode** support with theme toggle
- **12hr/24hr time format** toggle
- **Settings screen** with appearance controls and app info
- **Responsive framework** integration for multi-device support
- **SelectableText** throughout app for better UX
- **FittedBox overflow prevention** in schedule cells

### ✅ Recent Major Changes

#### Freezed Removal (2026-02-23) ✅
**Migrated from Freezed to simple immutable classes**
- Removed `freezed` and `freezed_annotation` dependencies
- Converted 12 model files to simple classes with manual implementations
- Implemented copyWith(), ==, hashCode, and toString() for all models
- Migrated to Hive CE's @GenerateAdapters pattern
- Removed all @HiveType/@HiveField annotations from models
- Fixed Freezed .when() pattern matching to use if/else type checks
- Deleted all .freezed.dart generated files
- All tests passing with 0 errors

**Benefits**:
- Simpler, more maintainable code
- No Freezed magic or generated files
- Better Hive CE integration with @GenerateAdapters
- Easier to understand for new developers

---

### 🐛 Known Issues

#### Android Build Issue
**Status**: Pending fix  
**Error**: `image_gallery_saver` package namespace error  
**Impact**: App builds fine on Linux/Desktop but fails on Android  
**Solution**: Need to add namespace to the package's build.gradle or update to a newer version

---

### 📋 Next Tasks

#### Immediate Priorities
1. **Fix Android build** - Resolve image_gallery_saver namespace issue
2. **Test with real schedule data** - Verify parser works with actual student schedules
3. **Implement semester filtering** - Wire up the filter logic in SavedSchedulesScreen

#### Future Enhancements
4. **Class notes functionality** - Models exist, need UI implementation
5. **Notifications** - Service defined but not implemented
6. ✅ **QR code sharing** - COMPLETED with gzip compression
7. ✅ **Home screen widget** - COMPLETED for Android/iOS
8. ✅ **Schedule comparison** - COMPLETED with free time detection

---

## Architecture Notes

### Clean Architecture Layers
```
lib/
├── domain/           # Pure Dart - business logic
│   ├── models/      # Simple immutable classes (no Freezed)
│   ├── services/    # Stateless business logic
│   └── repositories/# Abstract interfaces
├── data/            # Implementation details
│   ├── repositories/# Hive CE implementations
│   └── local/       # Hive setup and adapters
├── presentation/    # Flutter UI
│   ├── providers/   # ChangeNotifier state management
│   ├── screens/     # Full-page screens
│   └── widgets/     # Reusable components
├── hive_adapters.dart # @GenerateAdapters specifications
└── main.dart        # App entry point
```

### Key Design Decisions
1. **Hive CE** over Hive for better type safety and community support
2. **Simple classes** instead of Freezed for easier maintenance
3. **@GenerateAdapters** for Hive CE type adapter generation
4. **Provider** with ChangeNotifier for simple, transparent state management
5. **Flutter Hooks** to reduce boilerplate in stateless widgets
6. **Material Design 3** for modern UI

### State Management Pattern
- Providers hold app state and business logic
- Widgets are kept simple, just display and user interaction
- `context.watch<Provider>()` for reactive updates
- `context.read<Provider>()` for one-time reads (e.g., in callbacks)

---

## Git Conventions ⭐ IMPORTANT

**Always follow these commit message conventions:**

### Format
```
<type>: <subject>

<optional body>
```

### Types
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `refactor:` - Code refactoring (no functionality change)
- `style:` - Code style/formatting changes
- `test:` - Adding or updating tests
- `chore:` - Maintenance tasks (dependencies, build config)
- `perf:` - Performance improvements

### Examples
```bash
feat: Add Settings screen with dark mode toggle

- Implemented SettingsScreen with appearance settings
- Added package_info_plus dependency
- Dark mode and time format toggles

fix: Resolve Freezed union type instantiation error

- Removed @JsonSerializable from abstract TimeSlot class
- Only concrete subclasses generate serialization code

refactor: Remove Freezed and migrate to simple classes

- Converted 12 model files to simple immutable classes
- Implemented manual copyWith(), ==, hashCode methods
- Migrated to @GenerateAdapters for Hive CE
```

### Best Practices
- Keep subject line under 72 characters
- Use imperative mood ("Add feature" not "Added feature")
- Capitalize first letter of subject
- No period at end of subject
- Separate subject from body with blank line
- Use body to explain *what* and *why*, not *how*

---

## Common Issues & Solutions

### Issue: setState during build
**Solution**: Use `Future.microtask()` to defer state changes:
```dart
useEffect(() {
  Future.microtask(() => context.read<Provider>().method());
  return null;
}, []);
```

### Issue: Type inference errors with generics
**Solution**: Always add explicit type annotations:
```dart
// Bad:
Widget _buildRow(row) { ... }

// Good:
Widget _buildRow(ScheduleRow row) { ... }
```

### Issue: Models need modification
**Solution**: Use `.copyWith()` to create new instances:
```dart
final updated = myModel.copyWith(field: newValue);
```

### Issue: Hive type adapter errors
**Solution**: Ensure all typeIds are unique (0-16) and regenerate with build_runner:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Testing Strategy

### Manual Test Cases
1. Parse sample schedule with 3+ classes
2. Save schedule with name and semester
3. Navigate to Saved screen and verify schedule appears
4. Delete schedule and confirm deletion
5. Toggle dark mode
6. Toggle 12hr/24hr format
7. Export to PDF and verify output
8. Export to Calendar (.ics) and import to calendar app
9. Create schedule with overlapping classes and verify conflict detection
10. Test on different screen sizes (responsive behavior)

### Sample Schedule for Testing
Located in `test_data/sample_schedule.txt`:
```
CS101 Computer Science Introduction to Programming * 8:00 AM - 9:30 AM Room 204 M W F * DOE, JOHN john.doe@example.com 3
MATH201 Mathematics Calculus I * 10:00 AM - 11:30 AM Room 305 T Th * SMITH, JANE jane.smith@example.edu 4
ENG102 English Literature and Composition * 1:00 PM - 2:30 PM Room 108 M W * BROWN, ALICE alice.brown@example.com 3
```

---

## Dependencies Overview

### Core
- `flutter` + `cupertino_icons`
- `provider: ^6.1.2` - State management
- `flutter_hooks: ^0.20.5` - Widget lifecycle hooks
- `json_annotation: ^4.9.0` - JSON serialization
- `hive_ce: ^2.6.0` - Local database (community edition)
- `hive_ce_flutter: ^2.1.0` - Hive Flutter integration
- `path_provider: ^2.1.4` - File system paths

### Features
- `screenshot: ^3.0.0` - PNG export
- `pdf: ^3.11.1` + `printing: ^5.13.3` - PDF generation
- `share_plus: ^10.0.3` - Share functionality
- `icalendar: ^0.1.3` - Calendar (.ics) export
- `qr_flutter: ^4.1.0` - QR code generation
- `intl: ^0.18.1` - Date formatting
- `responsive_framework: ^1.5.1` - Responsive layouts
- `uuid: ^4.5.1` - Unique ID generation
- `package_info_plus: ^8.1.2` - App version info

### Dev Dependencies
- `build_runner: ^2.4.13` - Code generation
- `json_serializable: ^6.8.0` - JSON serialization codegen
- `hive_ce_generator: ^1.6.0` - Hive adapters generation
- `flutter_lints: ^6.0.0` - Linting rules

---

## Code Style Guidelines

### General
- Use `const` constructors wherever possible
- Prefer composition over inheritance
- Keep widgets small and focused (<300 lines)
- Extract complex logic to services
- Use meaningful variable names (no abbreviations)
- Add comments for non-obvious code
- Group imports: Flutter -> Package -> Relative

### Models
- All models should be immutable (final fields)
- Implement copyWith() for models that need modification
- Implement ==, hashCode, and toString()
- Use @JsonSerializable() for JSON serialization
- Document all public fields and methods

### Widgets
- Prefer StatelessWidget + Hooks over StatefulWidget
- Use HookWidget from flutter_hooks
- Extract repeated UI into separate widgets
- Use const constructors for static widgets
- Keep build() methods focused and readable

### Providers
- Extend ChangeNotifier
- Call notifyListeners() after state changes
- Keep business logic in services, not providers
- Document all public methods
- Handle errors gracefully

---

## Build & Run Commands

### Development
```bash
# Install dependencies
flutter pub get

# Run code generation
flutter pub run build_runner build --delete-conflicting-outputs

# Run on device
flutter run

# Run on specific device
flutter run -d linux
flutter run -d android
flutter run -d chrome

# Hot reload: Press 'r' in terminal
# Hot restart: Press 'R' in terminal
```

### Analysis & Testing
```bash
# Analyze code
flutter analyze

# Run tests
flutter test

# Check for outdated packages
flutter pub outdated

# Clean build
flutter clean
flutter pub get
```

### Release Build
```bash
# Android
flutter build apk --release

# Linux
flutter build linux --release

# Web
flutter build web --release
```

---

## Project File Structure

```
addu_schedbuilder_flutter/
├── lib/
│   ├── domain/
│   │   ├── models/          # 13 model files (simple classes)
│   │   ├── services/        # 6 service files (business logic)
│   │   └── repositories/    # 2 repository interfaces
│   ├── data/
│   │   ├── local/
│   │   │   └── hive_setup.dart
│   │   └── repositories/    # 2 repository implementations
│   ├── presentation/
│   │   ├── providers/       # 4 provider files
│   │   ├── screens/         # 3 screen files
│   │   └── widgets/         # ~20 widget files
│   ├── hive_adapters.dart   # @GenerateAdapters specifications
│   └── main.dart
├── test_data/
│   └── sample_schedule.txt  # Sample data for testing
├── pubspec.yaml
├── README.md                # User-facing documentation
└── CLAUDE.md               # This file (developer notes)
```

---

## Performance Considerations

- Use `const` constructors to reduce rebuilds
- Use `RepaintBoundary` for complex widgets (schedule table)
- Use `ListView.builder` for long lists (saved schedules)
- Cache expensive computations in providers
- Use `useMemoized()` hook for derived state
- Avoid unnecessary `context.watch()` calls

---

## Accessibility

- All interactive elements have semantic labels
- Color contrast meets WCAG AA standards
- Supports screen readers (TalkBack, VoiceOver)
- Text is selectable for copying (SelectableText)
- Supports system font scaling
- Dark mode for low-light environments

---

**Last Updated**: 2026-02-23  
**Status**: Core features complete, Freezed removed, ready for testing and Android build fix  
**Next Session**: Fix Android build, test with real data, implement semester filtering
