// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_slot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TimeSlot _$TimeSlotFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'classSlot':
      return ClassSlot.fromJson(json);
    case 'barSlot':
      return BarSlot.fromJson(json);
    case 'emptySlot':
      return EmptySlot.fromJson(json);

    default:
      throw CheckedFromJsonException(
        json,
        'runtimeType',
        'TimeSlot',
        'Invalid union type "${json['runtimeType']}"!',
      );
  }
}

/// @nodoc
mixin _$TimeSlot {
  @HiveField(1)
  int get rowspan => throw _privateConstructorUsedError;
  @HiveField(2)
  int get colspan => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      @HiveField(0) ClassData classData,
      @HiveField(1) int rowspan,
      @HiveField(2) int colspan,
      @HiveField(3) int duration,
    )
    classSlot,
    required TResult Function(
      @HiveField(0) String label,
      @HiveField(1) int rowspan,
      @HiveField(2) int colspan,
    )
    barSlot,
    required TResult Function(
      @HiveField(0) int rowspan,
      @HiveField(1) int colspan,
    )
    emptySlot,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      @HiveField(0) ClassData classData,
      @HiveField(1) int rowspan,
      @HiveField(2) int colspan,
      @HiveField(3) int duration,
    )?
    classSlot,
    TResult? Function(
      @HiveField(0) String label,
      @HiveField(1) int rowspan,
      @HiveField(2) int colspan,
    )?
    barSlot,
    TResult? Function(@HiveField(0) int rowspan, @HiveField(1) int colspan)?
    emptySlot,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      @HiveField(0) ClassData classData,
      @HiveField(1) int rowspan,
      @HiveField(2) int colspan,
      @HiveField(3) int duration,
    )?
    classSlot,
    TResult Function(
      @HiveField(0) String label,
      @HiveField(1) int rowspan,
      @HiveField(2) int colspan,
    )?
    barSlot,
    TResult Function(@HiveField(0) int rowspan, @HiveField(1) int colspan)?
    emptySlot,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClassSlot value) classSlot,
    required TResult Function(BarSlot value) barSlot,
    required TResult Function(EmptySlot value) emptySlot,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClassSlot value)? classSlot,
    TResult? Function(BarSlot value)? barSlot,
    TResult? Function(EmptySlot value)? emptySlot,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClassSlot value)? classSlot,
    TResult Function(BarSlot value)? barSlot,
    TResult Function(EmptySlot value)? emptySlot,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Serializes this TimeSlot to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimeSlotCopyWith<TimeSlot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeSlotCopyWith<$Res> {
  factory $TimeSlotCopyWith(TimeSlot value, $Res Function(TimeSlot) then) =
      _$TimeSlotCopyWithImpl<$Res, TimeSlot>;
  @useResult
  $Res call({@HiveField(1) int rowspan, @HiveField(2) int colspan});
}

/// @nodoc
class _$TimeSlotCopyWithImpl<$Res, $Val extends TimeSlot>
    implements $TimeSlotCopyWith<$Res> {
  _$TimeSlotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? rowspan = null, Object? colspan = null}) {
    return _then(
      _value.copyWith(
            rowspan: null == rowspan
                ? _value.rowspan
                : rowspan // ignore: cast_nullable_to_non_nullable
                      as int,
            colspan: null == colspan
                ? _value.colspan
                : colspan // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClassSlotImplCopyWith<$Res>
    implements $TimeSlotCopyWith<$Res> {
  factory _$$ClassSlotImplCopyWith(
    _$ClassSlotImpl value,
    $Res Function(_$ClassSlotImpl) then,
  ) = __$$ClassSlotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) ClassData classData,
    @HiveField(1) int rowspan,
    @HiveField(2) int colspan,
    @HiveField(3) int duration,
  });

  $ClassDataCopyWith<$Res> get classData;
}

/// @nodoc
class __$$ClassSlotImplCopyWithImpl<$Res>
    extends _$TimeSlotCopyWithImpl<$Res, _$ClassSlotImpl>
    implements _$$ClassSlotImplCopyWith<$Res> {
  __$$ClassSlotImplCopyWithImpl(
    _$ClassSlotImpl _value,
    $Res Function(_$ClassSlotImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? classData = null,
    Object? rowspan = null,
    Object? colspan = null,
    Object? duration = null,
  }) {
    return _then(
      _$ClassSlotImpl(
        classData: null == classData
            ? _value.classData
            : classData // ignore: cast_nullable_to_non_nullable
                  as ClassData,
        rowspan: null == rowspan
            ? _value.rowspan
            : rowspan // ignore: cast_nullable_to_non_nullable
                  as int,
        colspan: null == colspan
            ? _value.colspan
            : colspan // ignore: cast_nullable_to_non_nullable
                  as int,
        duration: null == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }

  /// Create a copy of TimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClassDataCopyWith<$Res> get classData {
    return $ClassDataCopyWith<$Res>(_value.classData, (value) {
      return _then(_value.copyWith(classData: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 5, adapterName: 'ClassSlotAdapter')
class _$ClassSlotImpl extends ClassSlot {
  const _$ClassSlotImpl({
    @HiveField(0) required this.classData,
    @HiveField(1) this.rowspan = 1,
    @HiveField(2) this.colspan = 1,
    @HiveField(3) required this.duration,
    final String? $type,
  }) : $type = $type ?? 'classSlot',
       super._();

  factory _$ClassSlotImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassSlotImplFromJson(json);

  @override
  @HiveField(0)
  final ClassData classData;
  @override
  @JsonKey()
  @HiveField(1)
  final int rowspan;
  @override
  @JsonKey()
  @HiveField(2)
  final int colspan;
  @override
  @HiveField(3)
  final int duration;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TimeSlot.classSlot(classData: $classData, rowspan: $rowspan, colspan: $colspan, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassSlotImpl &&
            (identical(other.classData, classData) ||
                other.classData == classData) &&
            (identical(other.rowspan, rowspan) || other.rowspan == rowspan) &&
            (identical(other.colspan, colspan) || other.colspan == colspan) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, classData, rowspan, colspan, duration);

  /// Create a copy of TimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassSlotImplCopyWith<_$ClassSlotImpl> get copyWith =>
      __$$ClassSlotImplCopyWithImpl<_$ClassSlotImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      @HiveField(0) ClassData classData,
      @HiveField(1) int rowspan,
      @HiveField(2) int colspan,
      @HiveField(3) int duration,
    )
    classSlot,
    required TResult Function(
      @HiveField(0) String label,
      @HiveField(1) int rowspan,
      @HiveField(2) int colspan,
    )
    barSlot,
    required TResult Function(
      @HiveField(0) int rowspan,
      @HiveField(1) int colspan,
    )
    emptySlot,
  }) {
    return classSlot(classData, rowspan, colspan, duration);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      @HiveField(0) ClassData classData,
      @HiveField(1) int rowspan,
      @HiveField(2) int colspan,
      @HiveField(3) int duration,
    )?
    classSlot,
    TResult? Function(
      @HiveField(0) String label,
      @HiveField(1) int rowspan,
      @HiveField(2) int colspan,
    )?
    barSlot,
    TResult? Function(@HiveField(0) int rowspan, @HiveField(1) int colspan)?
    emptySlot,
  }) {
    return classSlot?.call(classData, rowspan, colspan, duration);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      @HiveField(0) ClassData classData,
      @HiveField(1) int rowspan,
      @HiveField(2) int colspan,
      @HiveField(3) int duration,
    )?
    classSlot,
    TResult Function(
      @HiveField(0) String label,
      @HiveField(1) int rowspan,
      @HiveField(2) int colspan,
    )?
    barSlot,
    TResult Function(@HiveField(0) int rowspan, @HiveField(1) int colspan)?
    emptySlot,
    required TResult orElse(),
  }) {
    if (classSlot != null) {
      return classSlot(classData, rowspan, colspan, duration);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClassSlot value) classSlot,
    required TResult Function(BarSlot value) barSlot,
    required TResult Function(EmptySlot value) emptySlot,
  }) {
    return classSlot(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClassSlot value)? classSlot,
    TResult? Function(BarSlot value)? barSlot,
    TResult? Function(EmptySlot value)? emptySlot,
  }) {
    return classSlot?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClassSlot value)? classSlot,
    TResult Function(BarSlot value)? barSlot,
    TResult Function(EmptySlot value)? emptySlot,
    required TResult orElse(),
  }) {
    if (classSlot != null) {
      return classSlot(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassSlotImplToJson(this);
  }
}

abstract class ClassSlot extends TimeSlot {
  const factory ClassSlot({
    @HiveField(0) required final ClassData classData,
    @HiveField(1) final int rowspan,
    @HiveField(2) final int colspan,
    @HiveField(3) required final int duration,
  }) = _$ClassSlotImpl;
  const ClassSlot._() : super._();

  factory ClassSlot.fromJson(Map<String, dynamic> json) =
      _$ClassSlotImpl.fromJson;

  @HiveField(0)
  ClassData get classData;
  @override
  @HiveField(1)
  int get rowspan;
  @override
  @HiveField(2)
  int get colspan;
  @HiveField(3)
  int get duration;

  /// Create a copy of TimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassSlotImplCopyWith<_$ClassSlotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BarSlotImplCopyWith<$Res> implements $TimeSlotCopyWith<$Res> {
  factory _$$BarSlotImplCopyWith(
    _$BarSlotImpl value,
    $Res Function(_$BarSlotImpl) then,
  ) = __$$BarSlotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) String label,
    @HiveField(1) int rowspan,
    @HiveField(2) int colspan,
  });
}

/// @nodoc
class __$$BarSlotImplCopyWithImpl<$Res>
    extends _$TimeSlotCopyWithImpl<$Res, _$BarSlotImpl>
    implements _$$BarSlotImplCopyWith<$Res> {
  __$$BarSlotImplCopyWithImpl(
    _$BarSlotImpl _value,
    $Res Function(_$BarSlotImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? rowspan = null,
    Object? colspan = null,
  }) {
    return _then(
      _$BarSlotImpl(
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        rowspan: null == rowspan
            ? _value.rowspan
            : rowspan // ignore: cast_nullable_to_non_nullable
                  as int,
        colspan: null == colspan
            ? _value.colspan
            : colspan // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 14, adapterName: 'BarSlotAdapter')
class _$BarSlotImpl extends BarSlot {
  const _$BarSlotImpl({
    @HiveField(0) required this.label,
    @HiveField(1) this.rowspan = 1,
    @HiveField(2) this.colspan = 1,
    final String? $type,
  }) : $type = $type ?? 'barSlot',
       super._();

  factory _$BarSlotImpl.fromJson(Map<String, dynamic> json) =>
      _$$BarSlotImplFromJson(json);

  @override
  @HiveField(0)
  final String label;
  @override
  @JsonKey()
  @HiveField(1)
  final int rowspan;
  @override
  @JsonKey()
  @HiveField(2)
  final int colspan;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TimeSlot.barSlot(label: $label, rowspan: $rowspan, colspan: $colspan)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BarSlotImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.rowspan, rowspan) || other.rowspan == rowspan) &&
            (identical(other.colspan, colspan) || other.colspan == colspan));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, label, rowspan, colspan);

  /// Create a copy of TimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BarSlotImplCopyWith<_$BarSlotImpl> get copyWith =>
      __$$BarSlotImplCopyWithImpl<_$BarSlotImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      @HiveField(0) ClassData classData,
      @HiveField(1) int rowspan,
      @HiveField(2) int colspan,
      @HiveField(3) int duration,
    )
    classSlot,
    required TResult Function(
      @HiveField(0) String label,
      @HiveField(1) int rowspan,
      @HiveField(2) int colspan,
    )
    barSlot,
    required TResult Function(
      @HiveField(0) int rowspan,
      @HiveField(1) int colspan,
    )
    emptySlot,
  }) {
    return barSlot(label, rowspan, colspan);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      @HiveField(0) ClassData classData,
      @HiveField(1) int rowspan,
      @HiveField(2) int colspan,
      @HiveField(3) int duration,
    )?
    classSlot,
    TResult? Function(
      @HiveField(0) String label,
      @HiveField(1) int rowspan,
      @HiveField(2) int colspan,
    )?
    barSlot,
    TResult? Function(@HiveField(0) int rowspan, @HiveField(1) int colspan)?
    emptySlot,
  }) {
    return barSlot?.call(label, rowspan, colspan);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      @HiveField(0) ClassData classData,
      @HiveField(1) int rowspan,
      @HiveField(2) int colspan,
      @HiveField(3) int duration,
    )?
    classSlot,
    TResult Function(
      @HiveField(0) String label,
      @HiveField(1) int rowspan,
      @HiveField(2) int colspan,
    )?
    barSlot,
    TResult Function(@HiveField(0) int rowspan, @HiveField(1) int colspan)?
    emptySlot,
    required TResult orElse(),
  }) {
    if (barSlot != null) {
      return barSlot(label, rowspan, colspan);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClassSlot value) classSlot,
    required TResult Function(BarSlot value) barSlot,
    required TResult Function(EmptySlot value) emptySlot,
  }) {
    return barSlot(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClassSlot value)? classSlot,
    TResult? Function(BarSlot value)? barSlot,
    TResult? Function(EmptySlot value)? emptySlot,
  }) {
    return barSlot?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClassSlot value)? classSlot,
    TResult Function(BarSlot value)? barSlot,
    TResult Function(EmptySlot value)? emptySlot,
    required TResult orElse(),
  }) {
    if (barSlot != null) {
      return barSlot(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$BarSlotImplToJson(this);
  }
}

abstract class BarSlot extends TimeSlot {
  const factory BarSlot({
    @HiveField(0) required final String label,
    @HiveField(1) final int rowspan,
    @HiveField(2) final int colspan,
  }) = _$BarSlotImpl;
  const BarSlot._() : super._();

  factory BarSlot.fromJson(Map<String, dynamic> json) = _$BarSlotImpl.fromJson;

  @HiveField(0)
  String get label;
  @override
  @HiveField(1)
  int get rowspan;
  @override
  @HiveField(2)
  int get colspan;

  /// Create a copy of TimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BarSlotImplCopyWith<_$BarSlotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EmptySlotImplCopyWith<$Res>
    implements $TimeSlotCopyWith<$Res> {
  factory _$$EmptySlotImplCopyWith(
    _$EmptySlotImpl value,
    $Res Function(_$EmptySlotImpl) then,
  ) = __$$EmptySlotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@HiveField(0) int rowspan, @HiveField(1) int colspan});
}

/// @nodoc
class __$$EmptySlotImplCopyWithImpl<$Res>
    extends _$TimeSlotCopyWithImpl<$Res, _$EmptySlotImpl>
    implements _$$EmptySlotImplCopyWith<$Res> {
  __$$EmptySlotImplCopyWithImpl(
    _$EmptySlotImpl _value,
    $Res Function(_$EmptySlotImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? rowspan = null, Object? colspan = null}) {
    return _then(
      _$EmptySlotImpl(
        rowspan: null == rowspan
            ? _value.rowspan
            : rowspan // ignore: cast_nullable_to_non_nullable
                  as int,
        colspan: null == colspan
            ? _value.colspan
            : colspan // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 15, adapterName: 'EmptySlotAdapter')
class _$EmptySlotImpl extends EmptySlot {
  const _$EmptySlotImpl({
    @HiveField(0) this.rowspan = 1,
    @HiveField(1) this.colspan = 1,
    final String? $type,
  }) : $type = $type ?? 'emptySlot',
       super._();

  factory _$EmptySlotImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmptySlotImplFromJson(json);

  @override
  @JsonKey()
  @HiveField(0)
  final int rowspan;
  @override
  @JsonKey()
  @HiveField(1)
  final int colspan;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TimeSlot.emptySlot(rowspan: $rowspan, colspan: $colspan)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmptySlotImpl &&
            (identical(other.rowspan, rowspan) || other.rowspan == rowspan) &&
            (identical(other.colspan, colspan) || other.colspan == colspan));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, rowspan, colspan);

  /// Create a copy of TimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmptySlotImplCopyWith<_$EmptySlotImpl> get copyWith =>
      __$$EmptySlotImplCopyWithImpl<_$EmptySlotImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      @HiveField(0) ClassData classData,
      @HiveField(1) int rowspan,
      @HiveField(2) int colspan,
      @HiveField(3) int duration,
    )
    classSlot,
    required TResult Function(
      @HiveField(0) String label,
      @HiveField(1) int rowspan,
      @HiveField(2) int colspan,
    )
    barSlot,
    required TResult Function(
      @HiveField(0) int rowspan,
      @HiveField(1) int colspan,
    )
    emptySlot,
  }) {
    return emptySlot(rowspan, colspan);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      @HiveField(0) ClassData classData,
      @HiveField(1) int rowspan,
      @HiveField(2) int colspan,
      @HiveField(3) int duration,
    )?
    classSlot,
    TResult? Function(
      @HiveField(0) String label,
      @HiveField(1) int rowspan,
      @HiveField(2) int colspan,
    )?
    barSlot,
    TResult? Function(@HiveField(0) int rowspan, @HiveField(1) int colspan)?
    emptySlot,
  }) {
    return emptySlot?.call(rowspan, colspan);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      @HiveField(0) ClassData classData,
      @HiveField(1) int rowspan,
      @HiveField(2) int colspan,
      @HiveField(3) int duration,
    )?
    classSlot,
    TResult Function(
      @HiveField(0) String label,
      @HiveField(1) int rowspan,
      @HiveField(2) int colspan,
    )?
    barSlot,
    TResult Function(@HiveField(0) int rowspan, @HiveField(1) int colspan)?
    emptySlot,
    required TResult orElse(),
  }) {
    if (emptySlot != null) {
      return emptySlot(rowspan, colspan);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClassSlot value) classSlot,
    required TResult Function(BarSlot value) barSlot,
    required TResult Function(EmptySlot value) emptySlot,
  }) {
    return emptySlot(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClassSlot value)? classSlot,
    TResult? Function(BarSlot value)? barSlot,
    TResult? Function(EmptySlot value)? emptySlot,
  }) {
    return emptySlot?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClassSlot value)? classSlot,
    TResult Function(BarSlot value)? barSlot,
    TResult Function(EmptySlot value)? emptySlot,
    required TResult orElse(),
  }) {
    if (emptySlot != null) {
      return emptySlot(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$EmptySlotImplToJson(this);
  }
}

abstract class EmptySlot extends TimeSlot {
  const factory EmptySlot({
    @HiveField(0) final int rowspan,
    @HiveField(1) final int colspan,
  }) = _$EmptySlotImpl;
  const EmptySlot._() : super._();

  factory EmptySlot.fromJson(Map<String, dynamic> json) =
      _$EmptySlotImpl.fromJson;

  @override
  @HiveField(0)
  int get rowspan;
  @override
  @HiveField(1)
  int get colspan;

  /// Create a copy of TimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmptySlotImplCopyWith<_$EmptySlotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
