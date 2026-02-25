import 'time.dart';
import 'weekday.dart';

/// Represents a time block in a schedule (busy or free)
class TimeBlock {
  final Weekday weekday;
  final Time startTime;
  final Time endTime;
  final bool isBusy;
  final String? label; // Class name if busy

  const TimeBlock({
    required this.weekday,
    required this.startTime,
    required this.endTime,
    required this.isBusy,
    this.label,
  });

  /// Get duration in minutes
  int get durationMinutes {
    final startMinutes = startTime.toMinutes();
    final endMinutes = endTime.toMinutes();
    return endMinutes - startMinutes;
  }

  /// Check if this block overlaps with another
  bool overlaps(TimeBlock other) {
    if (weekday != other.weekday) return false;

    final thisStart = startTime.toMinutes();
    final thisEnd = endTime.toMinutes();
    final otherStart = other.startTime.toMinutes();
    final otherEnd = other.endTime.toMinutes();

    return thisStart < otherEnd && otherStart < thisEnd;
  }

  /// Format time range as string
  String formatTimeRange(bool is24Hour) {
    return '${startTime.format(is24Hour)} - ${endTime.format(is24Hour)}';
  }

  @override
  String toString() {
    return 'TimeBlock(${weekday.shortName}: ${startTime.format(false)} - ${endTime.format(false)}, ${isBusy ? "Busy" : "Free"})';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeBlock &&
          weekday == other.weekday &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          isBusy == other.isBusy;

  @override
  int get hashCode =>
      weekday.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      isBusy.hashCode;
}
