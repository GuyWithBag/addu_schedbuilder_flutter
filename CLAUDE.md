# SchedBuilder - Claude Development Notes

## Project Overview
A Flutter schedule builder app that parses text schedules, visualizes them in a weekly grid, and provides features like conflict detection, statistics, and export capabilities.

## Current Status (2026-02-23)

### ✅ Completed Features
- Schedule parsing from text format
- Weekly grid visualization with color-coded classes
- Save/load schedules with Hive CE persistence
- **Export to PNG, PDF, and JSON with UI** ⭐ NEW
- Statistics widget with charts and visualizations
- Conflict detection with detailed UI
- Bottom navigation (Input, Saved, Settings screens)
- Dark mode support
- 12hr/24hr time format toggle
- Responsive framework integration
- **SelectableText throughout app** ⭐ NEW
- **FittedBox overflow prevention** ⭐ NEW

### ✅ Fixed Issues

#### ~~CRITICAL: Bottom Overflow in Schedule Cells~~ FIXED ✅
**Solution Applied**: Wrapped Column content in `FittedBox` with `BoxFit.scaleDown`
- This automatically scales down text when space is limited
- No more RenderFlex overflow errors
- Text remains readable and proportional

**Code Location**: `lib/presentation/widgets/schedule_class_cell.dart`

### 🐛 Known Issues

None currently! App is running smoothly.

---

### 📋 Future Tasks

#### High Priority
1. ~~**Fix bottom overflow in schedule cells**~~ ✅ DONE (FittedBox solution)
2. ~~**Add more SelectableText widgets**~~ ✅ DONE (stats, cards, conflicts)
3. ~~**Add RepaintBoundary for PNG export**~~ ✅ DONE (integrated with export UI)
4. **Test app with real schedule data** to ensure parsing works correctly

#### Medium Priority
5. **Implement semester filtering** in SavedSchedulesScreen
   - UI already exists, just need to wire up the filter logic
6. **Add navigation from Input screen to Saved screen** after saving
   - Currently shows snackbar with "View" action that does nothing
7. **Implement undo for schedule deletion**
   - Snackbar shows "Undo" button but functionality not implemented

#### Low Priority
8. **Calendar export (.ics)** - Service exists but not integrated in UI
9. **Class notes functionality** - Models exist but no UI
10. **Notifications** - Service defined but not implemented
11. **QR code sharing** - Package installed but not used
12. **Home screen widget** - For Android/iOS home screens

---

## Architecture Notes

### Clean Architecture Layers
```
lib/
├── domain/           # Pure Dart - business logic
│   ├── models/      # Freezed data classes with Hive annotations
│   ├── services/    # Stateless business logic
│   └── repositories/# Abstract interfaces
├── data/            # Implementation details
│   ├── repositories/# Hive CE implementations
│   └── local/       # Hive setup
└── presentation/    # Flutter UI
    ├── providers/   # ChangeNotifier state management
    ├── screens/     # Full-page screens
    └── widgets/     # Reusable components
```

### Key Design Decisions
1. **Hive CE** over Hive for better type safety and community support
2. **Freezed** for immutable models with proper equality
3. **Provider** with ChangeNotifier for simple, transparent state management
4. **Flutter Hooks** to reduce boilerplate in stateless widgets
5. **Material Design 3** for modern UI

### State Management Pattern
- Providers hold app state and business logic
- Widgets are kept simple, just display and user interaction
- `context.watch<Provider>()` for reactive updates
- `context.read<Provider>()` for one-time reads (e.g., in callbacks)

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

### Issue: Freezed models can't be modified
**Solution**: Use `.copyWith()` or build new objects instead of modifying fields

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
8. Create schedule with overlapping classes and verify conflict detection

### Sample Schedule for Testing
```
CS101 Computer Science Introduction to Programming * 8:00 AM - 9:30 AM Room 204 M W F * DOE, JOHN john.doe@example.com 3
MATH201 Mathematics Calculus I * 10:00 AM - 11:30 AM Room 305 T Th * SMITH, JANE jane.smith@example.edu 4
PHYS101 Physics Mechanics * 9:00 AM - 10:30 AM Lab 101 M W * BROWN, ALEX alex.brown@school.edu 4
```

---

## Git Workflow

All commits follow conventional format:
- Features: "Add [feature] with [details]"
- Fixes: "Fix [issue] by [solution]"
- Refactors: "Refactor [component] to [improvement]"

Recent commits show steady progress through planned features.

---

## Dependencies Overview

### Core
- `flutter` + `cupertino_icons`
- `provider` - State management
- `flutter_hooks` - Widget lifecycle hooks
- `freezed` + `json_annotation` - Immutable models
- `hive_ce` + `hive_ce_flutter` - Local database (community edition)

### Features
- `screenshot` - PNG export
- `pdf` + `printing` - PDF generation
- `share_plus` - Share functionality
- `qr_flutter` - QR code generation
- `intl` - Date formatting
- `responsive_framework` - Responsive layouts
- `uuid` - Unique ID generation

### Dev
- `build_runner` - Code generation
- `freezed_annotation` - Freezed codegen
- `hive_ce_generator` - Hive adapters

---

## Next Session Priorities

1. ~~FIX OVERFLOW~~ ✅ DONE - Used FittedBox with scaleDown
2. ~~Add export UI~~ ✅ DONE - Modal bottom sheet with PNG/PDF/JSON
3. ~~SelectableText~~ ✅ DONE - Added throughout stats and cards
4. Test with real schedule data
5. Wire up semester filtering
6. Add navigation after save

## Code Style Guidelines

- Use `const` constructors wherever possible
- Prefer composition over inheritance
- Keep widgets small and focused
- Extract complex logic to services
- Use meaningful variable names
- Add comments for non-obvious code
- Group imports: Flutter -> Package -> Relative

---

**Last Updated**: 2026-02-23
**Status**: Active development, core features complete, fixing UX issues
