import '../models/class_data.dart';
import '../models/class_period.dart';
import '../models/teacher.dart';
import '../models/time.dart';
import '../models/weekday.dart';

/// Result of parsing schedule text
class ParseResult {
  final bool isSuccess;
  final List<ClassData>? classes;
  final List<String>? errors;

  const ParseResult.success(this.classes) : isSuccess = true, errors = null;

  const ParseResult.failure(this.errors) : isSuccess = false, classes = null;
}

/// Service for parsing schedule text into ClassData objects
class ParserService {
  ParserService._();

  /// Parse schedule text and return ClassData objects or errors
  ///
  /// Expected format per line:
  /// CODE SUBJECT TITLE * TIME ROOM DAYS * TEACHER EMAIL UNITS
  ///
  /// Example:
  /// CS101 Computer Science Introduction to Programming * 8:00 AM - 9:30 AM Room 204 M W F * DOE, JOHN john.doe@example.com 3
  static ParseResult parse(String input) {
    if (input.trim().isEmpty) {
      return const ParseResult.failure(['Input is empty']);
    }

    final lines = input
        .split('\n')
        .where((line) => line.trim().isNotEmpty)
        .toList();
    final classes = <ClassData>[];
    final errors = <String>[];

    for (var i = 0; i < lines.length; i++) {
      final lineNum = i + 1;
      final line = lines[i].trim();

      try {
        final classData = _parseLine(line);
        classes.add(classData);
      } catch (e) {
        errors.add('Line $lineNum: ${e.toString()}');
      }
    }

    if (errors.isNotEmpty) {
      return ParseResult.failure(errors);
    }

    return ParseResult.success(classes);
  }

  static ClassData _parseLine(String line) {
    // Split by * to get main sections
    final parts = line.split('*').map((p) => p.trim()).toList();

    if (parts.length < 2) {
      throw FormatException(
        'Invalid format: expected at least 2 sections separated by *',
      );
    }

    // Section 1: CODE SUBJECT TITLE
    final classPart = parts[0];
    final classMatch = RegExp(
      r'^([A-Z]+\d+)\s+(.+?)(?:\s+(.+))?$',
    ).firstMatch(classPart);

    if (classMatch == null) {
      throw FormatException(
        'Could not parse class code and subject from: $classPart',
      );
    }

    final code = classMatch.group(1)!;
    final subject = classMatch.group(2)!;
    final title = classMatch.group(3) ?? subject;

    // Section 2: TIME ROOM DAYS
    final schedulePart = parts[1];
    final period = _parseSchedule(schedulePart);

    // Section 3 (optional): TEACHER EMAIL UNITS
    Teacher? teacher;
    int units = 3; // Default units

    if (parts.length >= 3) {
      final teacherPart = parts[2];
      final teacherData = _parseTeacher(teacherPart);
      teacher = teacherData.$1;
      units = teacherData.$2;
    }

    return ClassData(
      code: code,
      subject: subject,
      title: title,
      schedule: [period],
      teacher: teacher,
      units: units,
    );
  }

  static ClassPeriod _parseSchedule(String schedulePart) {
    // Parse time: "8:00 AM - 9:30 AM"
    final timePattern = RegExp(
      r'(\d{1,2}):(\d{2})\s*(AM|PM)\s*-\s*(\d{1,2}):(\d{2})\s*(AM|PM)',
    );
    final timeMatch = timePattern.firstMatch(schedulePart);

    if (timeMatch == null) {
      throw FormatException('Could not parse time from: $schedulePart');
    }

    final startHour = int.parse(timeMatch.group(1)!);
    final startMinute = int.parse(timeMatch.group(2)!);
    final startPeriod = timeMatch.group(3)!;
    final endHour = int.parse(timeMatch.group(4)!);
    final endMinute = int.parse(timeMatch.group(5)!);
    final endPeriod = timeMatch.group(6)!;

    final start = Time(
      hour: _to24Hour(startHour, startPeriod),
      minute: startMinute,
    );

    final end = Time(hour: _to24Hour(endHour, endPeriod), minute: endMinute);

    // Parse room: "Room 204"
    final roomPattern = RegExp(r'Room\s+(\w+)', caseSensitive: false);
    final roomMatch = roomPattern.firstMatch(schedulePart);
    final room = roomMatch?.group(1) ?? 'TBA';

    // Parse weekdays: M, T, W, Th, F, Sa, S
    final weekdays = <Weekday>[];
    final weekdayPattern = RegExp(r'\b(M|T|W|Th|F|Sa|S)\b');
    final weekdayMatches = weekdayPattern.allMatches(schedulePart);

    for (final match in weekdayMatches) {
      final dayStr = match.group(1)!;
      try {
        final day = Weekday.fromShortName(dayStr);
        if (!weekdays.contains(day)) {
          weekdays.add(day);
        }
      } catch (e) {
        // Skip invalid weekday
      }
    }

    if (weekdays.isEmpty) {
      throw FormatException('No valid weekdays found in: $schedulePart');
    }

    return ClassPeriod(start: start, end: end, room: room, weekdays: weekdays);
  }

  static (Teacher, int) _parseTeacher(String teacherPart) {
    // Parse: "DOE, JOHN john.doe@example.com 3"
    final parts = teacherPart.split(RegExp(r'\s+'));

    if (parts.isEmpty) {
      throw FormatException('Empty teacher section');
    }

    // Find name (format: FAMILY, GIVEN)
    String? familyName;
    String? givenName;
    final emails = <String>[];
    int units = 3;

    for (var i = 0; i < parts.length; i++) {
      final part = parts[i];

      // Check if it's a number (units)
      if (RegExp(r'^\d+$').hasMatch(part)) {
        units = int.parse(part);
        continue;
      }

      // Check if it's an email
      if (part.contains('@')) {
        emails.add(part);
        continue;
      }

      // Otherwise, it's part of the name
      if (part.endsWith(',')) {
        familyName = part.substring(0, part.length - 1);
      } else if (familyName != null && givenName == null) {
        givenName = part;
      }
    }

    if (familyName == null || givenName == null) {
      throw FormatException('Could not parse teacher name from: $teacherPart');
    }

    final teacher = Teacher(
      familyName: familyName,
      givenName: givenName,
      emails: emails,
    );

    return (teacher, units);
  }

  static int _to24Hour(int hour, String period) {
    if (period == 'AM') {
      return hour == 12 ? 0 : hour;
    } else {
      return hour == 12 ? 12 : hour + 12;
    }
  }
}
