# SchedBuilder

A smart schedule builder for students that helps parse, visualize, and manage class schedules.

## Features

✅ **Text Parsing** - Automatically parse schedule text into structured data  
✅ **Visual Grid** - Weekly schedule grid view with color-coded classes  
✅ **Save & Manage** - Save multiple schedules (different semesters)  
✅ **Export Options** - Export to PNG, PDF, Calendar (.ics), and JSON  
✅ **Conflict Detection** - Automatically detect overlapping classes  
✅ **Statistics** - View total hours, busiest day, and class distribution  
✅ **Dark Mode** - Full dark mode support  
✅ **Time Format** - Toggle between 12-hour and 24-hour format  

## Getting Started

### Prerequisites

- Flutter 3.18+ with Dart 3.11+
- For Android: Android SDK 21+
- For iOS: iOS 12+
- For Linux: GTK 3.0+

### Installation

```bash
# Clone the repository
git clone <repository-url>
cd addu_schedbuilder_flutter

# Install dependencies
flutter pub get

# Run code generation
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

### Testing the Parser

Use the sample schedule text from `test_data/sample_schedule.txt` or paste your own schedule in this format:

```
CODE SUBJECT TITLE * TIME ROOM DAYS * INSTRUCTOR EMAIL UNITS
```

Example:
```
CS101 Computer Science Intro to Programming * 8:00 AM - 9:30 AM Room 204 M W F * DOE, JOHN john.doe@example.com 3
MATH201 Mathematics Calculus I * 10:00 AM - 11:30 AM Room 305 T Th * SMITH, JANE jane.smith@example.edu 4
```

**Format Rules:**
- Sections separated by ` * `
- Days: S (Sunday), M (Monday), T (Tuesday), W (Wednesday), Th (Thursday), F (Friday), Sa (Saturday)
- Time: 12-hour format with AM/PM (e.g., `8:00 AM - 9:30 AM`)
- Units: Integer number at the end

## Architecture

The app follows clean architecture principles with three layers:

```
┌─────────────────────────┐
│   Presentation Layer    │  Flutter widgets + Providers
├─────────────────────────┤
│     Domain Layer        │  Models + Services (Pure Dart)
├─────────────────────────┤
│      Data Layer         │  Hive persistence
└─────────────────────────┘
```

### Key Technologies

- **State Management**: Provider + ChangeNotifier
- **UI**: Flutter Hooks + Material 3
- **Persistence**: Hive CE (Community Edition)
- **Code Generation**: json_serializable + build_runner
- **Export**: pdf, screenshot, share_plus

## Project Structure

```
lib/
├── domain/
│   ├── models/          # Data models (immutable classes)
│   ├── services/        # Business logic services
│   └── repositories/    # Repository interfaces
├── data/
│   ├── local/           # Hive setup and adapters
│   └── repositories/    # Repository implementations
├── presentation/
│   ├── providers/       # State management (ChangeNotifier)
│   ├── screens/         # App screens
│   └── widgets/         # Reusable widgets
├── hive_adapters.dart   # Hive CE adapter specifications
└── main.dart            # App entry point
```

## Development

### Running Tests

```bash
flutter test
```

### Code Generation

After modifying models, regenerate code:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Analyzing Code

```bash
flutter analyze
```

## Roadmap

- [ ] Notifications for class reminders
- [ ] QR code sharing
- [ ] Home screen widget
- [ ] Compare schedules feature
- [ ] Cloud sync (optional)

## License

MIT License - See LICENSE file for details

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
