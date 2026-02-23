// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_preset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ColorData _$ColorDataFromJson(Map<String, dynamic> json) {
  return _ColorData.fromJson(json);
}

/// @nodoc
mixin _$ColorData {
  @HiveField(0)
  int get red => throw _privateConstructorUsedError;
  @HiveField(1)
  int get green => throw _privateConstructorUsedError;
  @HiveField(2)
  int get blue => throw _privateConstructorUsedError;
  @HiveField(3)
  int get alpha => throw _privateConstructorUsedError;

  /// Serializes this ColorData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ColorData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ColorDataCopyWith<ColorData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ColorDataCopyWith<$Res> {
  factory $ColorDataCopyWith(ColorData value, $Res Function(ColorData) then) =
      _$ColorDataCopyWithImpl<$Res, ColorData>;
  @useResult
  $Res call({
    @HiveField(0) int red,
    @HiveField(1) int green,
    @HiveField(2) int blue,
    @HiveField(3) int alpha,
  });
}

/// @nodoc
class _$ColorDataCopyWithImpl<$Res, $Val extends ColorData>
    implements $ColorDataCopyWith<$Res> {
  _$ColorDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ColorData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? red = null,
    Object? green = null,
    Object? blue = null,
    Object? alpha = null,
  }) {
    return _then(
      _value.copyWith(
            red: null == red
                ? _value.red
                : red // ignore: cast_nullable_to_non_nullable
                      as int,
            green: null == green
                ? _value.green
                : green // ignore: cast_nullable_to_non_nullable
                      as int,
            blue: null == blue
                ? _value.blue
                : blue // ignore: cast_nullable_to_non_nullable
                      as int,
            alpha: null == alpha
                ? _value.alpha
                : alpha // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ColorDataImplCopyWith<$Res>
    implements $ColorDataCopyWith<$Res> {
  factory _$$ColorDataImplCopyWith(
    _$ColorDataImpl value,
    $Res Function(_$ColorDataImpl) then,
  ) = __$$ColorDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) int red,
    @HiveField(1) int green,
    @HiveField(2) int blue,
    @HiveField(3) int alpha,
  });
}

/// @nodoc
class __$$ColorDataImplCopyWithImpl<$Res>
    extends _$ColorDataCopyWithImpl<$Res, _$ColorDataImpl>
    implements _$$ColorDataImplCopyWith<$Res> {
  __$$ColorDataImplCopyWithImpl(
    _$ColorDataImpl _value,
    $Res Function(_$ColorDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ColorData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? red = null,
    Object? green = null,
    Object? blue = null,
    Object? alpha = null,
  }) {
    return _then(
      _$ColorDataImpl(
        red: null == red
            ? _value.red
            : red // ignore: cast_nullable_to_non_nullable
                  as int,
        green: null == green
            ? _value.green
            : green // ignore: cast_nullable_to_non_nullable
                  as int,
        blue: null == blue
            ? _value.blue
            : blue // ignore: cast_nullable_to_non_nullable
                  as int,
        alpha: null == alpha
            ? _value.alpha
            : alpha // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ColorDataImpl implements _ColorData {
  const _$ColorDataImpl({
    @HiveField(0) required this.red,
    @HiveField(1) required this.green,
    @HiveField(2) required this.blue,
    @HiveField(3) this.alpha = 255,
  });

  factory _$ColorDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ColorDataImplFromJson(json);

  @override
  @HiveField(0)
  final int red;
  @override
  @HiveField(1)
  final int green;
  @override
  @HiveField(2)
  final int blue;
  @override
  @JsonKey()
  @HiveField(3)
  final int alpha;

  @override
  String toString() {
    return 'ColorData(red: $red, green: $green, blue: $blue, alpha: $alpha)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ColorDataImpl &&
            (identical(other.red, red) || other.red == red) &&
            (identical(other.green, green) || other.green == green) &&
            (identical(other.blue, blue) || other.blue == blue) &&
            (identical(other.alpha, alpha) || other.alpha == alpha));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, red, green, blue, alpha);

  /// Create a copy of ColorData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ColorDataImplCopyWith<_$ColorDataImpl> get copyWith =>
      __$$ColorDataImplCopyWithImpl<_$ColorDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ColorDataImplToJson(this);
  }
}

abstract class _ColorData implements ColorData {
  const factory _ColorData({
    @HiveField(0) required final int red,
    @HiveField(1) required final int green,
    @HiveField(2) required final int blue,
    @HiveField(3) final int alpha,
  }) = _$ColorDataImpl;

  factory _ColorData.fromJson(Map<String, dynamic> json) =
      _$ColorDataImpl.fromJson;

  @override
  @HiveField(0)
  int get red;
  @override
  @HiveField(1)
  int get green;
  @override
  @HiveField(2)
  int get blue;
  @override
  @HiveField(3)
  int get alpha;

  /// Create a copy of ColorData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ColorDataImplCopyWith<_$ColorDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ThemePreset _$ThemePresetFromJson(Map<String, dynamic> json) {
  return _ThemePreset.fromJson(json);
}

/// @nodoc
mixin _$ThemePreset {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  Map<String, ColorData> get classColors => throw _privateConstructorUsedError;
  @HiveField(3)
  bool get isDarkMode => throw _privateConstructorUsedError;

  /// Serializes this ThemePreset to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ThemePreset
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ThemePresetCopyWith<ThemePreset> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemePresetCopyWith<$Res> {
  factory $ThemePresetCopyWith(
    ThemePreset value,
    $Res Function(ThemePreset) then,
  ) = _$ThemePresetCopyWithImpl<$Res, ThemePreset>;
  @useResult
  $Res call({
    @HiveField(0) String id,
    @HiveField(1) String name,
    @HiveField(2) Map<String, ColorData> classColors,
    @HiveField(3) bool isDarkMode,
  });
}

/// @nodoc
class _$ThemePresetCopyWithImpl<$Res, $Val extends ThemePreset>
    implements $ThemePresetCopyWith<$Res> {
  _$ThemePresetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ThemePreset
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? classColors = null,
    Object? isDarkMode = null,
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
            classColors: null == classColors
                ? _value.classColors
                : classColors // ignore: cast_nullable_to_non_nullable
                      as Map<String, ColorData>,
            isDarkMode: null == isDarkMode
                ? _value.isDarkMode
                : isDarkMode // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ThemePresetImplCopyWith<$Res>
    implements $ThemePresetCopyWith<$Res> {
  factory _$$ThemePresetImplCopyWith(
    _$ThemePresetImpl value,
    $Res Function(_$ThemePresetImpl) then,
  ) = __$$ThemePresetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) String id,
    @HiveField(1) String name,
    @HiveField(2) Map<String, ColorData> classColors,
    @HiveField(3) bool isDarkMode,
  });
}

/// @nodoc
class __$$ThemePresetImplCopyWithImpl<$Res>
    extends _$ThemePresetCopyWithImpl<$Res, _$ThemePresetImpl>
    implements _$$ThemePresetImplCopyWith<$Res> {
  __$$ThemePresetImplCopyWithImpl(
    _$ThemePresetImpl _value,
    $Res Function(_$ThemePresetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ThemePreset
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? classColors = null,
    Object? isDarkMode = null,
  }) {
    return _then(
      _$ThemePresetImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        classColors: null == classColors
            ? _value._classColors
            : classColors // ignore: cast_nullable_to_non_nullable
                  as Map<String, ColorData>,
        isDarkMode: null == isDarkMode
            ? _value.isDarkMode
            : isDarkMode // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ThemePresetImpl extends _ThemePreset {
  const _$ThemePresetImpl({
    @HiveField(0) required this.id,
    @HiveField(1) required this.name,
    @HiveField(2) final Map<String, ColorData> classColors = const {},
    @HiveField(3) this.isDarkMode = false,
  }) : _classColors = classColors,
       super._();

  factory _$ThemePresetImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThemePresetImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  final Map<String, ColorData> _classColors;
  @override
  @JsonKey()
  @HiveField(2)
  Map<String, ColorData> get classColors {
    if (_classColors is EqualUnmodifiableMapView) return _classColors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_classColors);
  }

  @override
  @JsonKey()
  @HiveField(3)
  final bool isDarkMode;

  @override
  String toString() {
    return 'ThemePreset(id: $id, name: $name, classColors: $classColors, isDarkMode: $isDarkMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThemePresetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(
              other._classColors,
              _classColors,
            ) &&
            (identical(other.isDarkMode, isDarkMode) ||
                other.isDarkMode == isDarkMode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    const DeepCollectionEquality().hash(_classColors),
    isDarkMode,
  );

  /// Create a copy of ThemePreset
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ThemePresetImplCopyWith<_$ThemePresetImpl> get copyWith =>
      __$$ThemePresetImplCopyWithImpl<_$ThemePresetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ThemePresetImplToJson(this);
  }
}

abstract class _ThemePreset extends ThemePreset {
  const factory _ThemePreset({
    @HiveField(0) required final String id,
    @HiveField(1) required final String name,
    @HiveField(2) final Map<String, ColorData> classColors,
    @HiveField(3) final bool isDarkMode,
  }) = _$ThemePresetImpl;
  const _ThemePreset._() : super._();

  factory _ThemePreset.fromJson(Map<String, dynamic> json) =
      _$ThemePresetImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  Map<String, ColorData> get classColors;
  @override
  @HiveField(3)
  bool get isDarkMode;

  /// Create a copy of ThemePreset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ThemePresetImplCopyWith<_$ThemePresetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
