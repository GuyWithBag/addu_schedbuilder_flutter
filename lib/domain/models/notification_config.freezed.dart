// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NotificationConfig _$NotificationConfigFromJson(Map<String, dynamic> json) {
  return _NotificationConfig.fromJson(json);
}

/// @nodoc
mixin _$NotificationConfig {
  @HiveField(0)
  bool get enabled => throw _privateConstructorUsedError;
  @HiveField(1)
  int get minutesBefore => throw _privateConstructorUsedError;
  @HiveField(2)
  Set<Weekday> get activeDays => throw _privateConstructorUsedError;

  /// Serializes this NotificationConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationConfigCopyWith<NotificationConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationConfigCopyWith<$Res> {
  factory $NotificationConfigCopyWith(
    NotificationConfig value,
    $Res Function(NotificationConfig) then,
  ) = _$NotificationConfigCopyWithImpl<$Res, NotificationConfig>;
  @useResult
  $Res call({
    @HiveField(0) bool enabled,
    @HiveField(1) int minutesBefore,
    @HiveField(2) Set<Weekday> activeDays,
  });
}

/// @nodoc
class _$NotificationConfigCopyWithImpl<$Res, $Val extends NotificationConfig>
    implements $NotificationConfigCopyWith<$Res> {
  _$NotificationConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? minutesBefore = null,
    Object? activeDays = null,
  }) {
    return _then(
      _value.copyWith(
            enabled: null == enabled
                ? _value.enabled
                : enabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            minutesBefore: null == minutesBefore
                ? _value.minutesBefore
                : minutesBefore // ignore: cast_nullable_to_non_nullable
                      as int,
            activeDays: null == activeDays
                ? _value.activeDays
                : activeDays // ignore: cast_nullable_to_non_nullable
                      as Set<Weekday>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NotificationConfigImplCopyWith<$Res>
    implements $NotificationConfigCopyWith<$Res> {
  factory _$$NotificationConfigImplCopyWith(
    _$NotificationConfigImpl value,
    $Res Function(_$NotificationConfigImpl) then,
  ) = __$$NotificationConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) bool enabled,
    @HiveField(1) int minutesBefore,
    @HiveField(2) Set<Weekday> activeDays,
  });
}

/// @nodoc
class __$$NotificationConfigImplCopyWithImpl<$Res>
    extends _$NotificationConfigCopyWithImpl<$Res, _$NotificationConfigImpl>
    implements _$$NotificationConfigImplCopyWith<$Res> {
  __$$NotificationConfigImplCopyWithImpl(
    _$NotificationConfigImpl _value,
    $Res Function(_$NotificationConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? minutesBefore = null,
    Object? activeDays = null,
  }) {
    return _then(
      _$NotificationConfigImpl(
        enabled: null == enabled
            ? _value.enabled
            : enabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        minutesBefore: null == minutesBefore
            ? _value.minutesBefore
            : minutesBefore // ignore: cast_nullable_to_non_nullable
                  as int,
        activeDays: null == activeDays
            ? _value._activeDays
            : activeDays // ignore: cast_nullable_to_non_nullable
                  as Set<Weekday>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationConfigImpl extends _NotificationConfig {
  const _$NotificationConfigImpl({
    @HiveField(0) this.enabled = false,
    @HiveField(1) this.minutesBefore = 10,
    @HiveField(2) final Set<Weekday> activeDays = const {},
  }) : _activeDays = activeDays,
       super._();

  factory _$NotificationConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationConfigImplFromJson(json);

  @override
  @JsonKey()
  @HiveField(0)
  final bool enabled;
  @override
  @JsonKey()
  @HiveField(1)
  final int minutesBefore;
  final Set<Weekday> _activeDays;
  @override
  @JsonKey()
  @HiveField(2)
  Set<Weekday> get activeDays {
    if (_activeDays is EqualUnmodifiableSetView) return _activeDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_activeDays);
  }

  @override
  String toString() {
    return 'NotificationConfig(enabled: $enabled, minutesBefore: $minutesBefore, activeDays: $activeDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationConfigImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.minutesBefore, minutesBefore) ||
                other.minutesBefore == minutesBefore) &&
            const DeepCollectionEquality().equals(
              other._activeDays,
              _activeDays,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    enabled,
    minutesBefore,
    const DeepCollectionEquality().hash(_activeDays),
  );

  /// Create a copy of NotificationConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationConfigImplCopyWith<_$NotificationConfigImpl> get copyWith =>
      __$$NotificationConfigImplCopyWithImpl<_$NotificationConfigImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationConfigImplToJson(this);
  }
}

abstract class _NotificationConfig extends NotificationConfig {
  const factory _NotificationConfig({
    @HiveField(0) final bool enabled,
    @HiveField(1) final int minutesBefore,
    @HiveField(2) final Set<Weekday> activeDays,
  }) = _$NotificationConfigImpl;
  const _NotificationConfig._() : super._();

  factory _NotificationConfig.fromJson(Map<String, dynamic> json) =
      _$NotificationConfigImpl.fromJson;

  @override
  @HiveField(0)
  bool get enabled;
  @override
  @HiveField(1)
  int get minutesBefore;
  @override
  @HiveField(2)
  Set<Weekday> get activeDays;

  /// Create a copy of NotificationConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationConfigImplCopyWith<_$NotificationConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
