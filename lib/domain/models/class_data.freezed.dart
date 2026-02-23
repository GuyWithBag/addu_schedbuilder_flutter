// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'class_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ClassData _$ClassDataFromJson(Map<String, dynamic> json) {
  return _ClassData.fromJson(json);
}

/// @nodoc
mixin _$ClassData {
  @HiveField(0)
  String get code => throw _privateConstructorUsedError;
  @HiveField(1)
  String get subject => throw _privateConstructorUsedError;
  @HiveField(2)
  String get title => throw _privateConstructorUsedError;
  @HiveField(3)
  List<ClassPeriod> get schedule => throw _privateConstructorUsedError;
  @HiveField(4)
  Teacher? get teacher => throw _privateConstructorUsedError;
  @HiveField(5)
  int get units => throw _privateConstructorUsedError;

  /// Serializes this ClassData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClassData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClassDataCopyWith<ClassData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassDataCopyWith<$Res> {
  factory $ClassDataCopyWith(ClassData value, $Res Function(ClassData) then) =
      _$ClassDataCopyWithImpl<$Res, ClassData>;
  @useResult
  $Res call({
    @HiveField(0) String code,
    @HiveField(1) String subject,
    @HiveField(2) String title,
    @HiveField(3) List<ClassPeriod> schedule,
    @HiveField(4) Teacher? teacher,
    @HiveField(5) int units,
  });

  $TeacherCopyWith<$Res>? get teacher;
}

/// @nodoc
class _$ClassDataCopyWithImpl<$Res, $Val extends ClassData>
    implements $ClassDataCopyWith<$Res> {
  _$ClassDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClassData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? subject = null,
    Object? title = null,
    Object? schedule = null,
    Object? teacher = freezed,
    Object? units = null,
  }) {
    return _then(
      _value.copyWith(
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            subject: null == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            schedule: null == schedule
                ? _value.schedule
                : schedule // ignore: cast_nullable_to_non_nullable
                      as List<ClassPeriod>,
            teacher: freezed == teacher
                ? _value.teacher
                : teacher // ignore: cast_nullable_to_non_nullable
                      as Teacher?,
            units: null == units
                ? _value.units
                : units // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  /// Create a copy of ClassData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TeacherCopyWith<$Res>? get teacher {
    if (_value.teacher == null) {
      return null;
    }

    return $TeacherCopyWith<$Res>(_value.teacher!, (value) {
      return _then(_value.copyWith(teacher: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClassDataImplCopyWith<$Res>
    implements $ClassDataCopyWith<$Res> {
  factory _$$ClassDataImplCopyWith(
    _$ClassDataImpl value,
    $Res Function(_$ClassDataImpl) then,
  ) = __$$ClassDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) String code,
    @HiveField(1) String subject,
    @HiveField(2) String title,
    @HiveField(3) List<ClassPeriod> schedule,
    @HiveField(4) Teacher? teacher,
    @HiveField(5) int units,
  });

  @override
  $TeacherCopyWith<$Res>? get teacher;
}

/// @nodoc
class __$$ClassDataImplCopyWithImpl<$Res>
    extends _$ClassDataCopyWithImpl<$Res, _$ClassDataImpl>
    implements _$$ClassDataImplCopyWith<$Res> {
  __$$ClassDataImplCopyWithImpl(
    _$ClassDataImpl _value,
    $Res Function(_$ClassDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClassData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? subject = null,
    Object? title = null,
    Object? schedule = null,
    Object? teacher = freezed,
    Object? units = null,
  }) {
    return _then(
      _$ClassDataImpl(
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        subject: null == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        schedule: null == schedule
            ? _value._schedule
            : schedule // ignore: cast_nullable_to_non_nullable
                  as List<ClassPeriod>,
        teacher: freezed == teacher
            ? _value.teacher
            : teacher // ignore: cast_nullable_to_non_nullable
                  as Teacher?,
        units: null == units
            ? _value.units
            : units // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassDataImpl extends _ClassData {
  const _$ClassDataImpl({
    @HiveField(0) required this.code,
    @HiveField(1) required this.subject,
    @HiveField(2) required this.title,
    @HiveField(3) required final List<ClassPeriod> schedule,
    @HiveField(4) this.teacher,
    @HiveField(5) this.units = 3,
  }) : _schedule = schedule,
       super._();

  factory _$ClassDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassDataImplFromJson(json);

  @override
  @HiveField(0)
  final String code;
  @override
  @HiveField(1)
  final String subject;
  @override
  @HiveField(2)
  final String title;
  final List<ClassPeriod> _schedule;
  @override
  @HiveField(3)
  List<ClassPeriod> get schedule {
    if (_schedule is EqualUnmodifiableListView) return _schedule;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_schedule);
  }

  @override
  @HiveField(4)
  final Teacher? teacher;
  @override
  @JsonKey()
  @HiveField(5)
  final int units;

  @override
  String toString() {
    return 'ClassData(code: $code, subject: $subject, title: $title, schedule: $schedule, teacher: $teacher, units: $units)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassDataImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._schedule, _schedule) &&
            (identical(other.teacher, teacher) || other.teacher == teacher) &&
            (identical(other.units, units) || other.units == units));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    code,
    subject,
    title,
    const DeepCollectionEquality().hash(_schedule),
    teacher,
    units,
  );

  /// Create a copy of ClassData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassDataImplCopyWith<_$ClassDataImpl> get copyWith =>
      __$$ClassDataImplCopyWithImpl<_$ClassDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassDataImplToJson(this);
  }
}

abstract class _ClassData extends ClassData {
  const factory _ClassData({
    @HiveField(0) required final String code,
    @HiveField(1) required final String subject,
    @HiveField(2) required final String title,
    @HiveField(3) required final List<ClassPeriod> schedule,
    @HiveField(4) final Teacher? teacher,
    @HiveField(5) final int units,
  }) = _$ClassDataImpl;
  const _ClassData._() : super._();

  factory _ClassData.fromJson(Map<String, dynamic> json) =
      _$ClassDataImpl.fromJson;

  @override
  @HiveField(0)
  String get code;
  @override
  @HiveField(1)
  String get subject;
  @override
  @HiveField(2)
  String get title;
  @override
  @HiveField(3)
  List<ClassPeriod> get schedule;
  @override
  @HiveField(4)
  Teacher? get teacher;
  @override
  @HiveField(5)
  int get units;

  /// Create a copy of ClassData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassDataImplCopyWith<_$ClassDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
