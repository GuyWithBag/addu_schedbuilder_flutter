import 'package:json_annotation/json_annotation.dart';
import 'note_type.dart';

part 'class_note.g.dart';

@JsonSerializable()
class ClassNote {
  final String id;
  final String classCode;
  final String content;
  final DateTime createdAt;
  final NoteType type;

  const ClassNote({
    required this.id,
    required this.classCode,
    required this.content,
    required this.createdAt,
    this.type = NoteType.general,
  });

  /// JSON serialization
  factory ClassNote.fromJson(Map<String, dynamic> json) =>
      _$ClassNoteFromJson(json);
  Map<String, dynamic> toJson() => _$ClassNoteToJson(this);

  /// CopyWith method for immutability
  ClassNote copyWith({
    String? id,
    String? classCode,
    String? content,
    DateTime? createdAt,
    NoteType? type,
  }) {
    return ClassNote(
      id: id ?? this.id,
      classCode: classCode ?? this.classCode,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
    );
  }

  /// Equality and hashCode
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassNote &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          classCode == other.classCode &&
          content == other.content &&
          createdAt == other.createdAt &&
          type == other.type;

  @override
  int get hashCode =>
      id.hashCode ^
      classCode.hashCode ^
      content.hashCode ^
      createdAt.hashCode ^
      type.hashCode;

  @override
  String toString() =>
      'ClassNote(id: $id, classCode: $classCode, content: $content, createdAt: $createdAt, type: $type)';
}
