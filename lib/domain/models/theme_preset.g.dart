// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_preset.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ColorDataAdapter extends TypeAdapter<ColorData> {
  @override
  final typeId = 9;

  @override
  ColorData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ColorData(
      red: (fields[0] as num).toInt(),
      green: (fields[1] as num).toInt(),
      blue: (fields[2] as num).toInt(),
      alpha: fields[3] == null ? 255 : (fields[3] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, ColorData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.red)
      ..writeByte(1)
      ..write(obj.green)
      ..writeByte(2)
      ..write(obj.blue)
      ..writeByte(3)
      ..write(obj.alpha);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColorDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ThemePresetAdapter extends TypeAdapter<ThemePreset> {
  @override
  final typeId = 10;

  @override
  ThemePreset read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ThemePreset(
      id: fields[0] as String,
      name: fields[1] as String,
      classColors: fields[2] == null
          ? {}
          : (fields[2] as Map).cast<String, ColorData>(),
      isDarkMode: fields[3] == null ? false : fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ThemePreset obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.classColors)
      ..writeByte(3)
      ..write(obj.isDarkMode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemePresetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ColorDataImpl _$$ColorDataImplFromJson(Map<String, dynamic> json) =>
    _$ColorDataImpl(
      red: (json['red'] as num).toInt(),
      green: (json['green'] as num).toInt(),
      blue: (json['blue'] as num).toInt(),
      alpha: (json['alpha'] as num?)?.toInt() ?? 255,
    );

Map<String, dynamic> _$$ColorDataImplToJson(_$ColorDataImpl instance) =>
    <String, dynamic>{
      'red': instance.red,
      'green': instance.green,
      'blue': instance.blue,
      'alpha': instance.alpha,
    };

_$ThemePresetImpl _$$ThemePresetImplFromJson(Map<String, dynamic> json) =>
    _$ThemePresetImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      classColors:
          (json['classColors'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, ColorData.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      isDarkMode: json['isDarkMode'] as bool? ?? false,
    );

Map<String, dynamic> _$$ThemePresetImplToJson(_$ThemePresetImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'classColors': instance.classColors,
      'isDarkMode': instance.isDarkMode,
    };
