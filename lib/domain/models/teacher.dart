import 'package:json_annotation/json_annotation.dart';

part 'teacher.g.dart';

@JsonSerializable()
class Teacher {
  final String familyName;
  final String givenName;
  final List<String> emails;

  const Teacher({
    required this.familyName,
    required this.givenName,
    required this.emails,
  });

  /// JSON serialization
  factory Teacher.fromJson(Map<String, dynamic> json) =>
      _$TeacherFromJson(json);
  Map<String, dynamic> toJson() => _$TeacherToJson(this);

  /// Get full name in "FamilyName, GivenName" format
  String get fullName => '$familyName, $givenName';

  /// Get primary email (first in list)
  String? get primaryEmail => emails.isNotEmpty ? emails.first : null;

  /// CopyWith method for immutability
  Teacher copyWith({
    String? familyName,
    String? givenName,
    List<String>? emails,
  }) {
    return Teacher(
      familyName: familyName ?? this.familyName,
      givenName: givenName ?? this.givenName,
      emails: emails ?? this.emails,
    );
  }

  /// Equality and hashCode
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Teacher &&
          runtimeType == other.runtimeType &&
          familyName == other.familyName &&
          givenName == other.givenName &&
          _listEquals(emails, other.emails);

  @override
  int get hashCode =>
      familyName.hashCode ^
      givenName.hashCode ^
      emails.fold(0, (prev, element) => prev ^ element.hashCode);

  @override
  String toString() =>
      'Teacher(familyName: $familyName, givenName: $givenName, emails: $emails)';

  static bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
