import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'note_type.dart';

part 'class_note.freezed.dart';
part 'class_note.g.dart';

@freezed
@HiveType(typeId: 10)
class ClassNote with _$ClassNote {
  const ClassNote._();

  const factory ClassNote({
    @HiveField(0) required String id,
    @HiveField(1) required String classCode,
    @HiveField(2) required String content,
    @HiveField(3) required DateTime createdAt,
    @HiveField(4) @Default(NoteType.general) NoteType type,
  }) = _ClassNote;

  factory ClassNote.fromJson(Map<String, dynamic> json) =>
      _$ClassNoteFromJson(json);
}
