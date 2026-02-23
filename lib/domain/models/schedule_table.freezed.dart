// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_table.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ScheduleTable _$ScheduleTableFromJson(Map<String, dynamic> json) {
  return _ScheduleTable.fromJson(json);
}

/// @nodoc
mixin _$ScheduleTable {
  @HiveField(0)
  List<ScheduleRow> get rows => throw _privateConstructorUsedError;
  @HiveField(1)
  Set<Weekday> get peWeekdays => throw _privateConstructorUsedError;
  @HiveField(2)
  Map<Weekday, bool> get weekdayConfig => throw _privateConstructorUsedError;

  /// Serializes this ScheduleTable to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScheduleTable
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScheduleTableCopyWith<ScheduleTable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleTableCopyWith<$Res> {
  factory $ScheduleTableCopyWith(
    ScheduleTable value,
    $Res Function(ScheduleTable) then,
  ) = _$ScheduleTableCopyWithImpl<$Res, ScheduleTable>;
  @useResult
  $Res call({
    @HiveField(0) List<ScheduleRow> rows,
    @HiveField(1) Set<Weekday> peWeekdays,
    @HiveField(2) Map<Weekday, bool> weekdayConfig,
  });
}

/// @nodoc
class _$ScheduleTableCopyWithImpl<$Res, $Val extends ScheduleTable>
    implements $ScheduleTableCopyWith<$Res> {
  _$ScheduleTableCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScheduleTable
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rows = null,
    Object? peWeekdays = null,
    Object? weekdayConfig = null,
  }) {
    return _then(
      _value.copyWith(
            rows: null == rows
                ? _value.rows
                : rows // ignore: cast_nullable_to_non_nullable
                      as List<ScheduleRow>,
            peWeekdays: null == peWeekdays
                ? _value.peWeekdays
                : peWeekdays // ignore: cast_nullable_to_non_nullable
                      as Set<Weekday>,
            weekdayConfig: null == weekdayConfig
                ? _value.weekdayConfig
                : weekdayConfig // ignore: cast_nullable_to_non_nullable
                      as Map<Weekday, bool>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ScheduleTableImplCopyWith<$Res>
    implements $ScheduleTableCopyWith<$Res> {
  factory _$$ScheduleTableImplCopyWith(
    _$ScheduleTableImpl value,
    $Res Function(_$ScheduleTableImpl) then,
  ) = __$$ScheduleTableImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) List<ScheduleRow> rows,
    @HiveField(1) Set<Weekday> peWeekdays,
    @HiveField(2) Map<Weekday, bool> weekdayConfig,
  });
}

/// @nodoc
class __$$ScheduleTableImplCopyWithImpl<$Res>
    extends _$ScheduleTableCopyWithImpl<$Res, _$ScheduleTableImpl>
    implements _$$ScheduleTableImplCopyWith<$Res> {
  __$$ScheduleTableImplCopyWithImpl(
    _$ScheduleTableImpl _value,
    $Res Function(_$ScheduleTableImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScheduleTable
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rows = null,
    Object? peWeekdays = null,
    Object? weekdayConfig = null,
  }) {
    return _then(
      _$ScheduleTableImpl(
        rows: null == rows
            ? _value._rows
            : rows // ignore: cast_nullable_to_non_nullable
                  as List<ScheduleRow>,
        peWeekdays: null == peWeekdays
            ? _value._peWeekdays
            : peWeekdays // ignore: cast_nullable_to_non_nullable
                  as Set<Weekday>,
        weekdayConfig: null == weekdayConfig
            ? _value._weekdayConfig
            : weekdayConfig // ignore: cast_nullable_to_non_nullable
                  as Map<Weekday, bool>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ScheduleTableImpl extends _ScheduleTable {
  const _$ScheduleTableImpl({
    @HiveField(0) required final List<ScheduleRow> rows,
    @HiveField(1) final Set<Weekday> peWeekdays = const {},
    @HiveField(2) final Map<Weekday, bool> weekdayConfig = const {},
  }) : _rows = rows,
       _peWeekdays = peWeekdays,
       _weekdayConfig = weekdayConfig,
       super._();

  factory _$ScheduleTableImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduleTableImplFromJson(json);

  final List<ScheduleRow> _rows;
  @override
  @HiveField(0)
  List<ScheduleRow> get rows {
    if (_rows is EqualUnmodifiableListView) return _rows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rows);
  }

  final Set<Weekday> _peWeekdays;
  @override
  @JsonKey()
  @HiveField(1)
  Set<Weekday> get peWeekdays {
    if (_peWeekdays is EqualUnmodifiableSetView) return _peWeekdays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_peWeekdays);
  }

  final Map<Weekday, bool> _weekdayConfig;
  @override
  @JsonKey()
  @HiveField(2)
  Map<Weekday, bool> get weekdayConfig {
    if (_weekdayConfig is EqualUnmodifiableMapView) return _weekdayConfig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_weekdayConfig);
  }

  @override
  String toString() {
    return 'ScheduleTable(rows: $rows, peWeekdays: $peWeekdays, weekdayConfig: $weekdayConfig)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleTableImpl &&
            const DeepCollectionEquality().equals(other._rows, _rows) &&
            const DeepCollectionEquality().equals(
              other._peWeekdays,
              _peWeekdays,
            ) &&
            const DeepCollectionEquality().equals(
              other._weekdayConfig,
              _weekdayConfig,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_rows),
    const DeepCollectionEquality().hash(_peWeekdays),
    const DeepCollectionEquality().hash(_weekdayConfig),
  );

  /// Create a copy of ScheduleTable
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleTableImplCopyWith<_$ScheduleTableImpl> get copyWith =>
      __$$ScheduleTableImplCopyWithImpl<_$ScheduleTableImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduleTableImplToJson(this);
  }
}

abstract class _ScheduleTable extends ScheduleTable {
  const factory _ScheduleTable({
    @HiveField(0) required final List<ScheduleRow> rows,
    @HiveField(1) final Set<Weekday> peWeekdays,
    @HiveField(2) final Map<Weekday, bool> weekdayConfig,
  }) = _$ScheduleTableImpl;
  const _ScheduleTable._() : super._();

  factory _ScheduleTable.fromJson(Map<String, dynamic> json) =
      _$ScheduleTableImpl.fromJson;

  @override
  @HiveField(0)
  List<ScheduleRow> get rows;
  @override
  @HiveField(1)
  Set<Weekday> get peWeekdays;
  @override
  @HiveField(2)
  Map<Weekday, bool> get weekdayConfig;

  /// Create a copy of ScheduleTable
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduleTableImplCopyWith<_$ScheduleTableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
