// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conflict_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ConflictInfo _$ConflictInfoFromJson(Map<String, dynamic> json) {
  return _ConflictInfo.fromJson(json);
}

/// @nodoc
mixin _$ConflictInfo {
  List<ClassData> get conflictingClasses => throw _privateConstructorUsedError;
  Time get startTime => throw _privateConstructorUsedError;
  Time get endTime => throw _privateConstructorUsedError;
  Weekday get weekday => throw _privateConstructorUsedError;

  /// Serializes this ConflictInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConflictInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConflictInfoCopyWith<ConflictInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConflictInfoCopyWith<$Res> {
  factory $ConflictInfoCopyWith(
    ConflictInfo value,
    $Res Function(ConflictInfo) then,
  ) = _$ConflictInfoCopyWithImpl<$Res, ConflictInfo>;
  @useResult
  $Res call({
    List<ClassData> conflictingClasses,
    Time startTime,
    Time endTime,
    Weekday weekday,
  });

  $TimeCopyWith<$Res> get startTime;
  $TimeCopyWith<$Res> get endTime;
}

/// @nodoc
class _$ConflictInfoCopyWithImpl<$Res, $Val extends ConflictInfo>
    implements $ConflictInfoCopyWith<$Res> {
  _$ConflictInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConflictInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conflictingClasses = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? weekday = null,
  }) {
    return _then(
      _value.copyWith(
            conflictingClasses: null == conflictingClasses
                ? _value.conflictingClasses
                : conflictingClasses // ignore: cast_nullable_to_non_nullable
                      as List<ClassData>,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as Time,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as Time,
            weekday: null == weekday
                ? _value.weekday
                : weekday // ignore: cast_nullable_to_non_nullable
                      as Weekday,
          )
          as $Val,
    );
  }

  /// Create a copy of ConflictInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimeCopyWith<$Res> get startTime {
    return $TimeCopyWith<$Res>(_value.startTime, (value) {
      return _then(_value.copyWith(startTime: value) as $Val);
    });
  }

  /// Create a copy of ConflictInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimeCopyWith<$Res> get endTime {
    return $TimeCopyWith<$Res>(_value.endTime, (value) {
      return _then(_value.copyWith(endTime: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConflictInfoImplCopyWith<$Res>
    implements $ConflictInfoCopyWith<$Res> {
  factory _$$ConflictInfoImplCopyWith(
    _$ConflictInfoImpl value,
    $Res Function(_$ConflictInfoImpl) then,
  ) = __$$ConflictInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ClassData> conflictingClasses,
    Time startTime,
    Time endTime,
    Weekday weekday,
  });

  @override
  $TimeCopyWith<$Res> get startTime;
  @override
  $TimeCopyWith<$Res> get endTime;
}

/// @nodoc
class __$$ConflictInfoImplCopyWithImpl<$Res>
    extends _$ConflictInfoCopyWithImpl<$Res, _$ConflictInfoImpl>
    implements _$$ConflictInfoImplCopyWith<$Res> {
  __$$ConflictInfoImplCopyWithImpl(
    _$ConflictInfoImpl _value,
    $Res Function(_$ConflictInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConflictInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conflictingClasses = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? weekday = null,
  }) {
    return _then(
      _$ConflictInfoImpl(
        conflictingClasses: null == conflictingClasses
            ? _value._conflictingClasses
            : conflictingClasses // ignore: cast_nullable_to_non_nullable
                  as List<ClassData>,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as Time,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as Time,
        weekday: null == weekday
            ? _value.weekday
            : weekday // ignore: cast_nullable_to_non_nullable
                  as Weekday,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConflictInfoImpl extends _ConflictInfo {
  const _$ConflictInfoImpl({
    required final List<ClassData> conflictingClasses,
    required this.startTime,
    required this.endTime,
    required this.weekday,
  }) : _conflictingClasses = conflictingClasses,
       super._();

  factory _$ConflictInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConflictInfoImplFromJson(json);

  final List<ClassData> _conflictingClasses;
  @override
  List<ClassData> get conflictingClasses {
    if (_conflictingClasses is EqualUnmodifiableListView)
      return _conflictingClasses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conflictingClasses);
  }

  @override
  final Time startTime;
  @override
  final Time endTime;
  @override
  final Weekday weekday;

  @override
  String toString() {
    return 'ConflictInfo(conflictingClasses: $conflictingClasses, startTime: $startTime, endTime: $endTime, weekday: $weekday)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConflictInfoImpl &&
            const DeepCollectionEquality().equals(
              other._conflictingClasses,
              _conflictingClasses,
            ) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.weekday, weekday) || other.weekday == weekday));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_conflictingClasses),
    startTime,
    endTime,
    weekday,
  );

  /// Create a copy of ConflictInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConflictInfoImplCopyWith<_$ConflictInfoImpl> get copyWith =>
      __$$ConflictInfoImplCopyWithImpl<_$ConflictInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConflictInfoImplToJson(this);
  }
}

abstract class _ConflictInfo extends ConflictInfo {
  const factory _ConflictInfo({
    required final List<ClassData> conflictingClasses,
    required final Time startTime,
    required final Time endTime,
    required final Weekday weekday,
  }) = _$ConflictInfoImpl;
  const _ConflictInfo._() : super._();

  factory _ConflictInfo.fromJson(Map<String, dynamic> json) =
      _$ConflictInfoImpl.fromJson;

  @override
  List<ClassData> get conflictingClasses;
  @override
  Time get startTime;
  @override
  Time get endTime;
  @override
  Weekday get weekday;

  /// Create a copy of ConflictInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConflictInfoImplCopyWith<_$ConflictInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
