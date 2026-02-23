// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'class_note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ClassNote _$ClassNoteFromJson(Map<String, dynamic> json) {
  return _ClassNote.fromJson(json);
}

/// @nodoc
mixin _$ClassNote {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get classCode => throw _privateConstructorUsedError;
  @HiveField(2)
  String get content => throw _privateConstructorUsedError;
  @HiveField(3)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(4)
  NoteType get type => throw _privateConstructorUsedError;

  /// Serializes this ClassNote to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClassNote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClassNoteCopyWith<ClassNote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassNoteCopyWith<$Res> {
  factory $ClassNoteCopyWith(ClassNote value, $Res Function(ClassNote) then) =
      _$ClassNoteCopyWithImpl<$Res, ClassNote>;
  @useResult
  $Res call({
    @HiveField(0) String id,
    @HiveField(1) String classCode,
    @HiveField(2) String content,
    @HiveField(3) DateTime createdAt,
    @HiveField(4) NoteType type,
  });
}

/// @nodoc
class _$ClassNoteCopyWithImpl<$Res, $Val extends ClassNote>
    implements $ClassNoteCopyWith<$Res> {
  _$ClassNoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClassNote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? classCode = null,
    Object? content = null,
    Object? createdAt = null,
    Object? type = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            classCode: null == classCode
                ? _value.classCode
                : classCode // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as NoteType,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClassNoteImplCopyWith<$Res>
    implements $ClassNoteCopyWith<$Res> {
  factory _$$ClassNoteImplCopyWith(
    _$ClassNoteImpl value,
    $Res Function(_$ClassNoteImpl) then,
  ) = __$$ClassNoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) String id,
    @HiveField(1) String classCode,
    @HiveField(2) String content,
    @HiveField(3) DateTime createdAt,
    @HiveField(4) NoteType type,
  });
}

/// @nodoc
class __$$ClassNoteImplCopyWithImpl<$Res>
    extends _$ClassNoteCopyWithImpl<$Res, _$ClassNoteImpl>
    implements _$$ClassNoteImplCopyWith<$Res> {
  __$$ClassNoteImplCopyWithImpl(
    _$ClassNoteImpl _value,
    $Res Function(_$ClassNoteImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClassNote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? classCode = null,
    Object? content = null,
    Object? createdAt = null,
    Object? type = null,
  }) {
    return _then(
      _$ClassNoteImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        classCode: null == classCode
            ? _value.classCode
            : classCode // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as NoteType,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassNoteImpl extends _ClassNote {
  const _$ClassNoteImpl({
    @HiveField(0) required this.id,
    @HiveField(1) required this.classCode,
    @HiveField(2) required this.content,
    @HiveField(3) required this.createdAt,
    @HiveField(4) this.type = NoteType.general,
  }) : super._();

  factory _$ClassNoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassNoteImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String classCode;
  @override
  @HiveField(2)
  final String content;
  @override
  @HiveField(3)
  final DateTime createdAt;
  @override
  @JsonKey()
  @HiveField(4)
  final NoteType type;

  @override
  String toString() {
    return 'ClassNote(id: $id, classCode: $classCode, content: $content, createdAt: $createdAt, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassNoteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.classCode, classCode) ||
                other.classCode == classCode) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, classCode, content, createdAt, type);

  /// Create a copy of ClassNote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassNoteImplCopyWith<_$ClassNoteImpl> get copyWith =>
      __$$ClassNoteImplCopyWithImpl<_$ClassNoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassNoteImplToJson(this);
  }
}

abstract class _ClassNote extends ClassNote {
  const factory _ClassNote({
    @HiveField(0) required final String id,
    @HiveField(1) required final String classCode,
    @HiveField(2) required final String content,
    @HiveField(3) required final DateTime createdAt,
    @HiveField(4) final NoteType type,
  }) = _$ClassNoteImpl;
  const _ClassNote._() : super._();

  factory _ClassNote.fromJson(Map<String, dynamic> json) =
      _$ClassNoteImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get classCode;
  @override
  @HiveField(2)
  String get content;
  @override
  @HiveField(3)
  DateTime get createdAt;
  @override
  @HiveField(4)
  NoteType get type;

  /// Create a copy of ClassNote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassNoteImplCopyWith<_$ClassNoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
