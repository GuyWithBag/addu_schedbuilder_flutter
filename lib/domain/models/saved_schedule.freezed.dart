// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SavedSchedule _$SavedScheduleFromJson(Map<String, dynamic> json) {
  return _SavedSchedule.fromJson(json);
}

/// @nodoc
mixin _$SavedSchedule {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(3)
  ScheduleTable get table => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get semester => throw _privateConstructorUsedError;
  @HiveField(5)
  ThemePreset? get themePreset => throw _privateConstructorUsedError;

  /// Serializes this SavedSchedule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SavedSchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SavedScheduleCopyWith<SavedSchedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavedScheduleCopyWith<$Res> {
  factory $SavedScheduleCopyWith(
    SavedSchedule value,
    $Res Function(SavedSchedule) then,
  ) = _$SavedScheduleCopyWithImpl<$Res, SavedSchedule>;
  @useResult
  $Res call({
    @HiveField(0) String id,
    @HiveField(1) String name,
    @HiveField(2) DateTime createdAt,
    @HiveField(3) ScheduleTable table,
    @HiveField(4) String? semester,
    @HiveField(5) ThemePreset? themePreset,
  });

  $ScheduleTableCopyWith<$Res> get table;
  $ThemePresetCopyWith<$Res>? get themePreset;
}

/// @nodoc
class _$SavedScheduleCopyWithImpl<$Res, $Val extends SavedSchedule>
    implements $SavedScheduleCopyWith<$Res> {
  _$SavedScheduleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SavedSchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
    Object? table = null,
    Object? semester = freezed,
    Object? themePreset = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            table: null == table
                ? _value.table
                : table // ignore: cast_nullable_to_non_nullable
                      as ScheduleTable,
            semester: freezed == semester
                ? _value.semester
                : semester // ignore: cast_nullable_to_non_nullable
                      as String?,
            themePreset: freezed == themePreset
                ? _value.themePreset
                : themePreset // ignore: cast_nullable_to_non_nullable
                      as ThemePreset?,
          )
          as $Val,
    );
  }

  /// Create a copy of SavedSchedule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ScheduleTableCopyWith<$Res> get table {
    return $ScheduleTableCopyWith<$Res>(_value.table, (value) {
      return _then(_value.copyWith(table: value) as $Val);
    });
  }

  /// Create a copy of SavedSchedule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ThemePresetCopyWith<$Res>? get themePreset {
    if (_value.themePreset == null) {
      return null;
    }

    return $ThemePresetCopyWith<$Res>(_value.themePreset!, (value) {
      return _then(_value.copyWith(themePreset: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SavedScheduleImplCopyWith<$Res>
    implements $SavedScheduleCopyWith<$Res> {
  factory _$$SavedScheduleImplCopyWith(
    _$SavedScheduleImpl value,
    $Res Function(_$SavedScheduleImpl) then,
  ) = __$$SavedScheduleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) String id,
    @HiveField(1) String name,
    @HiveField(2) DateTime createdAt,
    @HiveField(3) ScheduleTable table,
    @HiveField(4) String? semester,
    @HiveField(5) ThemePreset? themePreset,
  });

  @override
  $ScheduleTableCopyWith<$Res> get table;
  @override
  $ThemePresetCopyWith<$Res>? get themePreset;
}

/// @nodoc
class __$$SavedScheduleImplCopyWithImpl<$Res>
    extends _$SavedScheduleCopyWithImpl<$Res, _$SavedScheduleImpl>
    implements _$$SavedScheduleImplCopyWith<$Res> {
  __$$SavedScheduleImplCopyWithImpl(
    _$SavedScheduleImpl _value,
    $Res Function(_$SavedScheduleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SavedSchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
    Object? table = null,
    Object? semester = freezed,
    Object? themePreset = freezed,
  }) {
    return _then(
      _$SavedScheduleImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        table: null == table
            ? _value.table
            : table // ignore: cast_nullable_to_non_nullable
                  as ScheduleTable,
        semester: freezed == semester
            ? _value.semester
            : semester // ignore: cast_nullable_to_non_nullable
                  as String?,
        themePreset: freezed == themePreset
            ? _value.themePreset
            : themePreset // ignore: cast_nullable_to_non_nullable
                  as ThemePreset?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SavedScheduleImpl extends _SavedSchedule {
  const _$SavedScheduleImpl({
    @HiveField(0) required this.id,
    @HiveField(1) required this.name,
    @HiveField(2) required this.createdAt,
    @HiveField(3) required this.table,
    @HiveField(4) this.semester,
    @HiveField(5) this.themePreset,
  }) : super._();

  factory _$SavedScheduleImpl.fromJson(Map<String, dynamic> json) =>
      _$$SavedScheduleImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final DateTime createdAt;
  @override
  @HiveField(3)
  final ScheduleTable table;
  @override
  @HiveField(4)
  final String? semester;
  @override
  @HiveField(5)
  final ThemePreset? themePreset;

  @override
  String toString() {
    return 'SavedSchedule(id: $id, name: $name, createdAt: $createdAt, table: $table, semester: $semester, themePreset: $themePreset)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedScheduleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.table, table) || other.table == table) &&
            (identical(other.semester, semester) ||
                other.semester == semester) &&
            (identical(other.themePreset, themePreset) ||
                other.themePreset == themePreset));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    createdAt,
    table,
    semester,
    themePreset,
  );

  /// Create a copy of SavedSchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SavedScheduleImplCopyWith<_$SavedScheduleImpl> get copyWith =>
      __$$SavedScheduleImplCopyWithImpl<_$SavedScheduleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SavedScheduleImplToJson(this);
  }
}

abstract class _SavedSchedule extends SavedSchedule {
  const factory _SavedSchedule({
    @HiveField(0) required final String id,
    @HiveField(1) required final String name,
    @HiveField(2) required final DateTime createdAt,
    @HiveField(3) required final ScheduleTable table,
    @HiveField(4) final String? semester,
    @HiveField(5) final ThemePreset? themePreset,
  }) = _$SavedScheduleImpl;
  const _SavedSchedule._() : super._();

  factory _SavedSchedule.fromJson(Map<String, dynamic> json) =
      _$SavedScheduleImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  DateTime get createdAt;
  @override
  @HiveField(3)
  ScheduleTable get table;
  @override
  @HiveField(4)
  String? get semester;
  @override
  @HiveField(5)
  ThemePreset? get themePreset;

  /// Create a copy of SavedSchedule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SavedScheduleImplCopyWith<_$SavedScheduleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
