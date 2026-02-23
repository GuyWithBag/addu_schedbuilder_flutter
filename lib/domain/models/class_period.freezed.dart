// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'class_period.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ClassPeriod _$ClassPeriodFromJson(Map<String, dynamic> json) {
  return _ClassPeriod.fromJson(json);
}

/// @nodoc
mixin _$ClassPeriod {
  @HiveField(0)
  Time get start => throw _privateConstructorUsedError;
  @HiveField(1)
  Time get end => throw _privateConstructorUsedError;
  @HiveField(2)
  String get room => throw _privateConstructorUsedError;
  @HiveField(3)
  List<Weekday> get weekdays => throw _privateConstructorUsedError;

  /// Serializes this ClassPeriod to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClassPeriod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClassPeriodCopyWith<ClassPeriod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassPeriodCopyWith<$Res> {
  factory $ClassPeriodCopyWith(
    ClassPeriod value,
    $Res Function(ClassPeriod) then,
  ) = _$ClassPeriodCopyWithImpl<$Res, ClassPeriod>;
  @useResult
  $Res call({
    @HiveField(0) Time start,
    @HiveField(1) Time end,
    @HiveField(2) String room,
    @HiveField(3) List<Weekday> weekdays,
  });

  $TimeCopyWith<$Res> get start;
  $TimeCopyWith<$Res> get end;
}

/// @nodoc
class _$ClassPeriodCopyWithImpl<$Res, $Val extends ClassPeriod>
    implements $ClassPeriodCopyWith<$Res> {
  _$ClassPeriodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClassPeriod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
    Object? room = null,
    Object? weekdays = null,
  }) {
    return _then(
      _value.copyWith(
            start: null == start
                ? _value.start
                : start // ignore: cast_nullable_to_non_nullable
                      as Time,
            end: null == end
                ? _value.end
                : end // ignore: cast_nullable_to_non_nullable
                      as Time,
            room: null == room
                ? _value.room
                : room // ignore: cast_nullable_to_non_nullable
                      as String,
            weekdays: null == weekdays
                ? _value.weekdays
                : weekdays // ignore: cast_nullable_to_non_nullable
                      as List<Weekday>,
          )
          as $Val,
    );
  }

  /// Create a copy of ClassPeriod
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimeCopyWith<$Res> get start {
    return $TimeCopyWith<$Res>(_value.start, (value) {
      return _then(_value.copyWith(start: value) as $Val);
    });
  }

  /// Create a copy of ClassPeriod
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimeCopyWith<$Res> get end {
    return $TimeCopyWith<$Res>(_value.end, (value) {
      return _then(_value.copyWith(end: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClassPeriodImplCopyWith<$Res>
    implements $ClassPeriodCopyWith<$Res> {
  factory _$$ClassPeriodImplCopyWith(
    _$ClassPeriodImpl value,
    $Res Function(_$ClassPeriodImpl) then,
  ) = __$$ClassPeriodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) Time start,
    @HiveField(1) Time end,
    @HiveField(2) String room,
    @HiveField(3) List<Weekday> weekdays,
  });

  @override
  $TimeCopyWith<$Res> get start;
  @override
  $TimeCopyWith<$Res> get end;
}

/// @nodoc
class __$$ClassPeriodImplCopyWithImpl<$Res>
    extends _$ClassPeriodCopyWithImpl<$Res, _$ClassPeriodImpl>
    implements _$$ClassPeriodImplCopyWith<$Res> {
  __$$ClassPeriodImplCopyWithImpl(
    _$ClassPeriodImpl _value,
    $Res Function(_$ClassPeriodImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClassPeriod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
    Object? room = null,
    Object? weekdays = null,
  }) {
    return _then(
      _$ClassPeriodImpl(
        start: null == start
            ? _value.start
            : start // ignore: cast_nullable_to_non_nullable
                  as Time,
        end: null == end
            ? _value.end
            : end // ignore: cast_nullable_to_non_nullable
                  as Time,
        room: null == room
            ? _value.room
            : room // ignore: cast_nullable_to_non_nullable
                  as String,
        weekdays: null == weekdays
            ? _value._weekdays
            : weekdays // ignore: cast_nullable_to_non_nullable
                  as List<Weekday>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassPeriodImpl extends _ClassPeriod {
  const _$ClassPeriodImpl({
    @HiveField(0) required this.start,
    @HiveField(1) required this.end,
    @HiveField(2) required this.room,
    @HiveField(3) required final List<Weekday> weekdays,
  }) : _weekdays = weekdays,
       super._();

  factory _$ClassPeriodImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassPeriodImplFromJson(json);

  @override
  @HiveField(0)
  final Time start;
  @override
  @HiveField(1)
  final Time end;
  @override
  @HiveField(2)
  final String room;
  final List<Weekday> _weekdays;
  @override
  @HiveField(3)
  List<Weekday> get weekdays {
    if (_weekdays is EqualUnmodifiableListView) return _weekdays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weekdays);
  }

  @override
  String toString() {
    return 'ClassPeriod(start: $start, end: $end, room: $room, weekdays: $weekdays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassPeriodImpl &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.room, room) || other.room == room) &&
            const DeepCollectionEquality().equals(other._weekdays, _weekdays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    start,
    end,
    room,
    const DeepCollectionEquality().hash(_weekdays),
  );

  /// Create a copy of ClassPeriod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassPeriodImplCopyWith<_$ClassPeriodImpl> get copyWith =>
      __$$ClassPeriodImplCopyWithImpl<_$ClassPeriodImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassPeriodImplToJson(this);
  }
}

abstract class _ClassPeriod extends ClassPeriod {
  const factory _ClassPeriod({
    @HiveField(0) required final Time start,
    @HiveField(1) required final Time end,
    @HiveField(2) required final String room,
    @HiveField(3) required final List<Weekday> weekdays,
  }) = _$ClassPeriodImpl;
  const _ClassPeriod._() : super._();

  factory _ClassPeriod.fromJson(Map<String, dynamic> json) =
      _$ClassPeriodImpl.fromJson;

  @override
  @HiveField(0)
  Time get start;
  @override
  @HiveField(1)
  Time get end;
  @override
  @HiveField(2)
  String get room;
  @override
  @HiveField(3)
  List<Weekday> get weekdays;

  /// Create a copy of ClassPeriod
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassPeriodImplCopyWith<_$ClassPeriodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
