import 'package:json_annotation/json_annotation.dart';
import 'weekday.dart';
import 'theme_preset.dart';

part 'table_theme.g.dart';

@JsonSerializable()
class TableTheme {
  final String id;
  final String name;
  final DateTime createdAt;
  final ColorData tableBorderColor;
  final ColorData tableBackgroundColor;
  final double cornerRadius;
  final String? backgroundImagePath;
  final Map<Weekday, ColorData> weekdayColors;

  const TableTheme({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.tableBorderColor,
    required this.tableBackgroundColor,
    required this.cornerRadius,
    this.backgroundImagePath,
    required this.weekdayColors,
  });

  /// JSON serialization
  factory TableTheme.fromJson(Map<String, dynamic> json) =>
      _$TableThemeFromJson(json);
  Map<String, dynamic> toJson() => _$TableThemeToJson(this);

  /// CopyWith method for immutability
  TableTheme copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    ColorData? tableBorderColor,
    ColorData? tableBackgroundColor,
    double? cornerRadius,
    String? backgroundImagePath,
    Map<Weekday, ColorData>? weekdayColors,
  }) {
    return TableTheme(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      tableBorderColor: tableBorderColor ?? this.tableBorderColor,
      tableBackgroundColor: tableBackgroundColor ?? this.tableBackgroundColor,
      cornerRadius: cornerRadius ?? this.cornerRadius,
      backgroundImagePath: backgroundImagePath ?? this.backgroundImagePath,
      weekdayColors: weekdayColors ?? this.weekdayColors,
    );
  }

  /// Equality and hashCode
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TableTheme &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          createdAt == other.createdAt &&
          tableBorderColor == other.tableBorderColor &&
          tableBackgroundColor == other.tableBackgroundColor &&
          cornerRadius == other.cornerRadius &&
          backgroundImagePath == other.backgroundImagePath &&
          _mapsEqual(weekdayColors, other.weekdayColors);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      createdAt.hashCode ^
      tableBorderColor.hashCode ^
      tableBackgroundColor.hashCode ^
      cornerRadius.hashCode ^
      (backgroundImagePath?.hashCode ?? 0) ^
      weekdayColors.hashCode;

  @override
  String toString() =>
      'TableTheme(id: $id, name: $name, createdAt: $createdAt, cornerRadius: $cornerRadius)';

  static bool _mapsEqual<K, V>(Map<K, V>? a, Map<K, V>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key) || a[key] != b[key]) return false;
    }
    return true;
  }
}
