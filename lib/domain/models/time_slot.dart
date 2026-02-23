import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'class_data.dart';

part 'time_slot.freezed.dart';
part 'time_slot.g.dart';

/// Base class for schedule grid cells
@freezed
class TimeSlot with _$TimeSlot {
  const TimeSlot._();

  /// Cell containing a class
  @HiveType(typeId: 5, adapterName: 'ClassSlotAdapter')
  const factory TimeSlot.classSlot({
    @HiveField(0) required ClassData classData,
    @HiveField(1) @Default(1) int rowspan,
    @HiveField(2) @Default(1) int colspan,
    @HiveField(3) required int duration,
  }) = ClassSlot;

  /// Cell for breaks/lunch
  @HiveType(typeId: 14, adapterName: 'BarSlotAdapter')
  const factory TimeSlot.barSlot({
    @HiveField(0) required String label,
    @HiveField(1) @Default(1) int rowspan,
    @HiveField(2) @Default(1) int colspan,
  }) = BarSlot;

  /// Empty cell
  @HiveType(typeId: 15, adapterName: 'EmptySlotAdapter')
  const factory TimeSlot.emptySlot({
    @HiveField(0) @Default(1) int rowspan,
    @HiveField(1) @Default(1) int colspan,
  }) = EmptySlot;

  factory TimeSlot.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotFromJson(json);
}
