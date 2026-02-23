// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'teacher.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Teacher _$TeacherFromJson(Map<String, dynamic> json) {
  return _Teacher.fromJson(json);
}

/// @nodoc
mixin _$Teacher {
  @HiveField(0)
  String get familyName => throw _privateConstructorUsedError;
  @HiveField(1)
  String get givenName => throw _privateConstructorUsedError;
  @HiveField(2)
  List<String> get emails => throw _privateConstructorUsedError;

  /// Serializes this Teacher to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Teacher
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeacherCopyWith<Teacher> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeacherCopyWith<$Res> {
  factory $TeacherCopyWith(Teacher value, $Res Function(Teacher) then) =
      _$TeacherCopyWithImpl<$Res, Teacher>;
  @useResult
  $Res call({
    @HiveField(0) String familyName,
    @HiveField(1) String givenName,
    @HiveField(2) List<String> emails,
  });
}

/// @nodoc
class _$TeacherCopyWithImpl<$Res, $Val extends Teacher>
    implements $TeacherCopyWith<$Res> {
  _$TeacherCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Teacher
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? familyName = null,
    Object? givenName = null,
    Object? emails = null,
  }) {
    return _then(
      _value.copyWith(
            familyName: null == familyName
                ? _value.familyName
                : familyName // ignore: cast_nullable_to_non_nullable
                      as String,
            givenName: null == givenName
                ? _value.givenName
                : givenName // ignore: cast_nullable_to_non_nullable
                      as String,
            emails: null == emails
                ? _value.emails
                : emails // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TeacherImplCopyWith<$Res> implements $TeacherCopyWith<$Res> {
  factory _$$TeacherImplCopyWith(
    _$TeacherImpl value,
    $Res Function(_$TeacherImpl) then,
  ) = __$$TeacherImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) String familyName,
    @HiveField(1) String givenName,
    @HiveField(2) List<String> emails,
  });
}

/// @nodoc
class __$$TeacherImplCopyWithImpl<$Res>
    extends _$TeacherCopyWithImpl<$Res, _$TeacherImpl>
    implements _$$TeacherImplCopyWith<$Res> {
  __$$TeacherImplCopyWithImpl(
    _$TeacherImpl _value,
    $Res Function(_$TeacherImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Teacher
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? familyName = null,
    Object? givenName = null,
    Object? emails = null,
  }) {
    return _then(
      _$TeacherImpl(
        familyName: null == familyName
            ? _value.familyName
            : familyName // ignore: cast_nullable_to_non_nullable
                  as String,
        givenName: null == givenName
            ? _value.givenName
            : givenName // ignore: cast_nullable_to_non_nullable
                  as String,
        emails: null == emails
            ? _value._emails
            : emails // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TeacherImpl extends _Teacher {
  const _$TeacherImpl({
    @HiveField(0) required this.familyName,
    @HiveField(1) required this.givenName,
    @HiveField(2) required final List<String> emails,
  }) : _emails = emails,
       super._();

  factory _$TeacherImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeacherImplFromJson(json);

  @override
  @HiveField(0)
  final String familyName;
  @override
  @HiveField(1)
  final String givenName;
  final List<String> _emails;
  @override
  @HiveField(2)
  List<String> get emails {
    if (_emails is EqualUnmodifiableListView) return _emails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_emails);
  }

  @override
  String toString() {
    return 'Teacher(familyName: $familyName, givenName: $givenName, emails: $emails)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeacherImpl &&
            (identical(other.familyName, familyName) ||
                other.familyName == familyName) &&
            (identical(other.givenName, givenName) ||
                other.givenName == givenName) &&
            const DeepCollectionEquality().equals(other._emails, _emails));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    familyName,
    givenName,
    const DeepCollectionEquality().hash(_emails),
  );

  /// Create a copy of Teacher
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeacherImplCopyWith<_$TeacherImpl> get copyWith =>
      __$$TeacherImplCopyWithImpl<_$TeacherImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeacherImplToJson(this);
  }
}

abstract class _Teacher extends Teacher {
  const factory _Teacher({
    @HiveField(0) required final String familyName,
    @HiveField(1) required final String givenName,
    @HiveField(2) required final List<String> emails,
  }) = _$TeacherImpl;
  const _Teacher._() : super._();

  factory _Teacher.fromJson(Map<String, dynamic> json) = _$TeacherImpl.fromJson;

  @override
  @HiveField(0)
  String get familyName;
  @override
  @HiveField(1)
  String get givenName;
  @override
  @HiveField(2)
  List<String> get emails;

  /// Create a copy of Teacher
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeacherImplCopyWith<_$TeacherImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
