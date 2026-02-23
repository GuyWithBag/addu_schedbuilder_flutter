import 'package:hive_ce/hive.dart';

part 'weekday.g.dart';

/// Enum for days of the week
@HiveType(typeId: 1)
enum Weekday {
  @HiveField(0)
  sunday('S', 'Sunday', 0),

  @HiveField(1)
  monday('M', 'Monday', 1),

  @HiveField(2)
  tuesday('T', 'Tuesday', 2),

  @HiveField(3)
  wednesday('W', 'Wednesday', 3),

  @HiveField(4)
  thursday('Th', 'Thursday', 4),

  @HiveField(5)
  friday('F', 'Friday', 5),

  @HiveField(6)
  saturday('Sa', 'Saturday', 6);

  const Weekday(this.shortName, this.fullName, this.dayIndex);

  final String shortName;
  final String fullName;
  final int dayIndex;

  /// Parse weekday from short name (e.g., "M" -> Monday)
  static Weekday? fromShortName(String name) {
    return Weekday.values.firstWhere(
      (day) => day.shortName.toLowerCase() == name.toLowerCase(),
      orElse: () => throw ArgumentError('Invalid weekday: $name'),
    );
  }

  /// Get weekday from DateTime
  static Weekday fromDateTime(DateTime dateTime) {
    // DateTime.weekday: Monday = 1, Sunday = 7
    switch (dateTime.weekday) {
      case DateTime.monday:
        return Weekday.monday;
      case DateTime.tuesday:
        return Weekday.tuesday;
      case DateTime.wednesday:
        return Weekday.wednesday;
      case DateTime.thursday:
        return Weekday.thursday;
      case DateTime.friday:
        return Weekday.friday;
      case DateTime.saturday:
        return Weekday.saturday;
      case DateTime.sunday:
        return Weekday.sunday;
      default:
        throw ArgumentError('Invalid weekday: ${dateTime.weekday}');
    }
  }

  /// Convert to DateTime weekday value (1-7)
  int get dartWeekday {
    switch (this) {
      case Weekday.monday:
        return DateTime.monday;
      case Weekday.tuesday:
        return DateTime.tuesday;
      case Weekday.wednesday:
        return DateTime.wednesday;
      case Weekday.thursday:
        return DateTime.thursday;
      case Weekday.friday:
        return DateTime.friday;
      case Weekday.saturday:
        return DateTime.saturday;
      case Weekday.sunday:
        return DateTime.sunday;
    }
  }
}
