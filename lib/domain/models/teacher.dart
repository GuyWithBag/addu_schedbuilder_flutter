import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

part 'teacher.freezed.dart';
part 'teacher.g.dart';

@freezed
@HiveType(typeId: 3)
class Teacher with _$Teacher {
  const Teacher._();

  const factory Teacher({
    @HiveField(0) required String familyName,
    @HiveField(1) required String givenName,
    @HiveField(2) required List<String> emails,
  }) = _Teacher;

  factory Teacher.fromJson(Map<String, dynamic> json) =>
      _$TeacherFromJson(json);

  /// Get full name in "FamilyName, GivenName" format
  String get fullName => '$familyName, $givenName';

  /// Get primary email (first in list)
  String? get primaryEmail => emails.isNotEmpty ? emails.first : null;
}
