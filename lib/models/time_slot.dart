import 'package:json_annotation/json_annotation.dart';
import 'class_data.dart';

part 'time_slot.g.dart';

/// Base class for schedule grid cells
abstract class TimeSlot {
  const TimeSlot();

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    final type = json['runtimeType'] as String?;
    switch (type) {
      case 'classSlot':
        return ClassSlot.fromJson(json);
      case 'barSlot':
        return BarSlot.fromJson(json);
      case 'emptySlot':
        return EmptySlot.fromJson(json);
      default:
        throw ArgumentError('Unknown TimeSlot type: $type');
    }
  }

  Map<String, dynamic> toJson();
}

/// Cell containing a class
@JsonSerializable()
class ClassSlot extends TimeSlot {
  final ClassData classData;
  final int rowspan;
  final int colspan;
  final int duration;

  const ClassSlot({
    required this.classData,
    this.rowspan = 1,
    this.colspan = 1,
    required this.duration,
  });

  factory ClassSlot.fromJson(Map<String, dynamic> json) =>
      _$ClassSlotFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final json = _$ClassSlotToJson(this);
    json['runtimeType'] = 'classSlot';
    return json;
  }

  ClassSlot copyWith({
    ClassData? classData,
    int? rowspan,
    int? colspan,
    int? duration,
  }) {
    return ClassSlot(
      classData: classData ?? this.classData,
      rowspan: rowspan ?? this.rowspan,
      colspan: colspan ?? this.colspan,
      duration: duration ?? this.duration,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassSlot &&
          runtimeType == other.runtimeType &&
          classData == other.classData &&
          rowspan == other.rowspan &&
          colspan == other.colspan &&
          duration == other.duration;

  @override
  int get hashCode =>
      classData.hashCode ^
      rowspan.hashCode ^
      colspan.hashCode ^
      duration.hashCode;

  @override
  String toString() =>
      'ClassSlot(classData: $classData, rowspan: $rowspan, colspan: $colspan, duration: $duration)';
}

/// Cell for breaks/lunch
@JsonSerializable()
class BarSlot extends TimeSlot {
  final String label;
  final int rowspan;
  final int colspan;

  const BarSlot({required this.label, this.rowspan = 1, this.colspan = 1});

  factory BarSlot.fromJson(Map<String, dynamic> json) =>
      _$BarSlotFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final json = _$BarSlotToJson(this);
    json['runtimeType'] = 'barSlot';
    return json;
  }

  BarSlot copyWith({String? label, int? rowspan, int? colspan}) {
    return BarSlot(
      label: label ?? this.label,
      rowspan: rowspan ?? this.rowspan,
      colspan: colspan ?? this.colspan,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarSlot &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          rowspan == other.rowspan &&
          colspan == other.colspan;

  @override
  int get hashCode => label.hashCode ^ rowspan.hashCode ^ colspan.hashCode;

  @override
  String toString() =>
      'BarSlot(label: $label, rowspan: $rowspan, colspan: $colspan)';
}

/// Empty cell
@JsonSerializable()
class EmptySlot extends TimeSlot {
  final int rowspan;
  final int colspan;

  const EmptySlot({this.rowspan = 1, this.colspan = 1});

  factory EmptySlot.fromJson(Map<String, dynamic> json) =>
      _$EmptySlotFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final json = _$EmptySlotToJson(this);
    json['runtimeType'] = 'emptySlot';
    return json;
  }

  EmptySlot copyWith({int? rowspan, int? colspan}) {
    return EmptySlot(
      rowspan: rowspan ?? this.rowspan,
      colspan: colspan ?? this.colspan,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmptySlot &&
          runtimeType == other.runtimeType &&
          rowspan == other.rowspan &&
          colspan == other.colspan;

  @override
  int get hashCode => rowspan.hashCode ^ colspan.hashCode;

  @override
  String toString() => 'EmptySlot(rowspan: $rowspan, colspan: $colspan)';
}
