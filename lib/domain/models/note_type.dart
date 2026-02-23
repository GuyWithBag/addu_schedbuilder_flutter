import 'package:hive_ce/hive.dart';

part 'note_type.g.dart';

/// Type of class note
@HiveType(typeId: 11)
enum NoteType {
  @HiveField(0)
  general('General', 'General note'),

  @HiveField(1)
  homework('Homework', 'Homework assignment'),

  @HiveField(2)
  exam('Exam', 'Exam or quiz');

  const NoteType(this.label, this.description);

  final String label;
  final String description;
}
