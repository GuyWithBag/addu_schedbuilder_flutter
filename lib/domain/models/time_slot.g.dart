// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassSlot _$ClassSlotFromJson(Map<String, dynamic> json) => ClassSlot(
  classData: ClassData.fromJson(json['classData'] as Map<String, dynamic>),
  rowspan: (json['rowspan'] as num?)?.toInt() ?? 1,
  colspan: (json['colspan'] as num?)?.toInt() ?? 1,
  duration: (json['duration'] as num).toInt(),
);

Map<String, dynamic> _$ClassSlotToJson(ClassSlot instance) => <String, dynamic>{
  'classData': instance.classData,
  'rowspan': instance.rowspan,
  'colspan': instance.colspan,
  'duration': instance.duration,
};

BarSlot _$BarSlotFromJson(Map<String, dynamic> json) => BarSlot(
  label: json['label'] as String,
  rowspan: (json['rowspan'] as num?)?.toInt() ?? 1,
  colspan: (json['colspan'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$BarSlotToJson(BarSlot instance) => <String, dynamic>{
  'label': instance.label,
  'rowspan': instance.rowspan,
  'colspan': instance.colspan,
};

EmptySlot _$EmptySlotFromJson(Map<String, dynamic> json) => EmptySlot(
  rowspan: (json['rowspan'] as num?)?.toInt() ?? 1,
  colspan: (json['colspan'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$EmptySlotToJson(EmptySlot instance) => <String, dynamic>{
  'rowspan': instance.rowspan,
  'colspan': instance.colspan,
};
