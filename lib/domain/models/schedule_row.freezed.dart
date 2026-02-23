// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_row.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ScheduleRow _$ScheduleRowFromJson(Map<String, dynamic> json) {
  return _ScheduleRow.fromJson(json);
}

/// @nodoc
mixin _$ScheduleRow {
  @HiveField(0)
  Time get time => throw _privateConstructorUsedError;
  @HiveField(1)
  int get duration => throw _privateConstructorUsedError;
  @HiveField(2)
  List<TimeSlot?> get columns => throw _privateConstructorUsedError;

  /// Serializes this ScheduleRow to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScheduleRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScheduleRowCopyWith<ScheduleRow> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleRowCopyWith<$Res> {
  factory $ScheduleRowCopyWith(
    ScheduleRow value,
    $Res Function(ScheduleRow) then,
  ) = _$ScheduleRowCopyWithImpl<$Res, ScheduleRow>;
  @useResult
  $Res call({
    @HiveField(0) Time time,
    @HiveField(1) int duration,
    @HiveField(2) List<TimeSlot?> columns,
  });

  $TimeCopyWith<$Res> get time;
}

/// @nodoc
class _$ScheduleRowCopyWithImpl<$Res, $Val extends ScheduleRow>
    implements $ScheduleRowCopyWith<$Res> {
  _$ScheduleRowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScheduleRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? duration = null,
    Object? columns = null,
  }) {
    return _then(
      _value.copyWith(
            time: null == time
                ? _value.time
                : time // ignore: cast_nullable_to_non_nullable
                      as Time,
            duration: null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as int,
            columns: null == columns
                ? _value.columns
                : columns // ignore: cast_nullable_to_non_nullable
                      as List<TimeSlot?>,
          )
          as $Val,
    );
  }

  /// Create a copy of ScheduleRow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimeCopyWith<$Res> get time {
    return $TimeCopyWith<$Res>(_value.time, (value) {
      return _then(_value.copyWith(time: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ScheduleRowImplCopyWith<$Res>
    implements $ScheduleRowCopyWith<$Res> {
  factory _$$ScheduleRowImplCopyWith(
    _$ScheduleRowImpl value,
    $Res Function(_$ScheduleRowImpl) then,
  ) = __$$ScheduleRowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) Time time,
    @HiveField(1) int duration,
    @HiveField(2) List<TimeSlot?> columns,
  });

  @override
  $TimeCopyWith<$Res> get time;
}

/// @nodoc
class __$$ScheduleRowImplCopyWithImpl<$Res>
    extends _$ScheduleRowCopyWithImpl<$Res, _$ScheduleRowImpl>
    implements _$$ScheduleRowImplCopyWith<$Res> {
  __$$ScheduleRowImplCopyWithImpl(
    _$ScheduleRowImpl _value,
    $Res Function(_$ScheduleRowImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScheduleRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? duration = null,
    Object? columns = null,
  }) {
    return _then(
      _$ScheduleRowImpl(
        time: null == time
            ? _value.time
            : time // ignore: cast_nullable_to_non_nullable
                  as Time,
        duration: null == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as int,
        columns: null == columns
            ? _value._columns
            : columns // ignore: cast_nullable_to_non_nullable
                  as List<TimeSlot?>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ScheduleRowImpl extends _ScheduleRow {
  const _$ScheduleRowImpl({
    @HiveField(0) required this.time,
    @HiveField(1) required this.duration,
    @HiveField(2) required final List<TimeSlot?> columns,
  }) : _columns = columns,
       super._();

  factory _$ScheduleRowImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduleRowImplFromJson(json);

  @override
  @HiveField(0)
  final Time time;
  @override
  @HiveField(1)
  final int duration;
  final List<TimeSlot?> _columns;
  @override
  @HiveField(2)
  List<TimeSlot?> get columns {
    if (_columns is EqualUnmodifiableListView) return _columns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_columns);
  }

  @override
  String toString() {
    return 'ScheduleRow(time: $time, duration: $duration, columns: $columns)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleRowImpl &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            const DeepCollectionEquality().equals(other._columns, _columns));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    time,
    duration,
    const DeepCollectionEquality().hash(_columns),
  );

  /// Create a copy of ScheduleRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleRowImplCopyWith<_$ScheduleRowImpl> get copyWith =>
      __$$ScheduleRowImplCopyWithImpl<_$ScheduleRowImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduleRowImplToJson(this);
  }
}

abstract class _ScheduleRow extends ScheduleRow {
  const factory _ScheduleRow({
    @HiveField(0) required final Time time,
    @HiveField(1) required final int duration,
    @HiveField(2) required final List<TimeSlot?> columns,
  }) = _$ScheduleRowImpl;
  const _ScheduleRow._() : super._();

  factory _ScheduleRow.fromJson(Map<String, dynamic> json) =
      _$ScheduleRowImpl.fromJson;

  @override
  @HiveField(0)
  Time get time;
  @override
  @HiveField(1)
  int get duration;
  @override
  @HiveField(2)
  List<TimeSlot?> get columns;

  /// Create a copy of ScheduleRow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduleRowImplCopyWith<_$ScheduleRowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
