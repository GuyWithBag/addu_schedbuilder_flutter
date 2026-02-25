// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class TimeAdapter extends TypeAdapter<Time> {
  @override
  final typeId = 0;

  @override
  Time read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Time(
      hour: (fields[0] as num).toInt(),
      minute: (fields[1] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, Time obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.hour)
      ..writeByte(1)
      ..write(obj.minute);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WeekdayAdapter extends TypeAdapter<Weekday> {
  @override
  final typeId = 1;

  @override
  Weekday read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Weekday.sunday;
      case 1:
        return Weekday.monday;
      case 2:
        return Weekday.tuesday;
      case 3:
        return Weekday.wednesday;
      case 4:
        return Weekday.thursday;
      case 5:
        return Weekday.friday;
      case 6:
        return Weekday.saturday;
      default:
        return Weekday.sunday;
    }
  }

  @override
  void write(BinaryWriter writer, Weekday obj) {
    switch (obj) {
      case Weekday.sunday:
        writer.writeByte(0);
      case Weekday.monday:
        writer.writeByte(1);
      case Weekday.tuesday:
        writer.writeByte(2);
      case Weekday.wednesday:
        writer.writeByte(3);
      case Weekday.thursday:
        writer.writeByte(4);
      case Weekday.friday:
        writer.writeByte(5);
      case Weekday.saturday:
        writer.writeByte(6);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeekdayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ClassPeriodAdapter extends TypeAdapter<ClassPeriod> {
  @override
  final typeId = 2;

  @override
  ClassPeriod read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClassPeriod(
      start: fields[0] as Time,
      end: fields[1] as Time,
      room: fields[2] as String,
      weekdays: (fields[3] as List).cast<Weekday>(),
    );
  }

  @override
  void write(BinaryWriter writer, ClassPeriod obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.start)
      ..writeByte(1)
      ..write(obj.end)
      ..writeByte(2)
      ..write(obj.room)
      ..writeByte(3)
      ..write(obj.weekdays);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassPeriodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TeacherAdapter extends TypeAdapter<Teacher> {
  @override
  final typeId = 3;

  @override
  Teacher read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Teacher(
      familyName: fields[0] as String,
      givenName: fields[1] as String,
      emails: (fields[2] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Teacher obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.familyName)
      ..writeByte(1)
      ..write(obj.givenName)
      ..writeByte(2)
      ..write(obj.emails);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeacherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ClassDataAdapter extends TypeAdapter<ClassData> {
  @override
  final typeId = 4;

  @override
  ClassData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClassData(
      code: fields[0] as String,
      subject: fields[1] as String,
      title: fields[2] as String,
      schedule: (fields[3] as List).cast<ClassPeriod>(),
      teacher: fields[4] as Teacher?,
      units: fields[5] == null ? 3 : (fields[5] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, ClassData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.subject)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.schedule)
      ..writeByte(4)
      ..write(obj.teacher)
      ..writeByte(5)
      ..write(obj.units);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ClassSlotAdapter extends TypeAdapter<ClassSlot> {
  @override
  final typeId = 5;

  @override
  ClassSlot read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClassSlot(
      classData: fields[0] as ClassData,
      rowspan: fields[1] == null ? 1 : (fields[1] as num).toInt(),
      colspan: fields[2] == null ? 1 : (fields[2] as num).toInt(),
      duration: (fields[3] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, ClassSlot obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.classData)
      ..writeByte(1)
      ..write(obj.rowspan)
      ..writeByte(2)
      ..write(obj.colspan)
      ..writeByte(3)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassSlotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ScheduleRowAdapter extends TypeAdapter<ScheduleRow> {
  @override
  final typeId = 6;

  @override
  ScheduleRow read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduleRow(
      time: fields[0] as Time,
      duration: (fields[1] as num).toInt(),
      columns: (fields[2] as List).cast<TimeSlot?>(),
    );
  }

  @override
  void write(BinaryWriter writer, ScheduleRow obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.duration)
      ..writeByte(2)
      ..write(obj.columns);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleRowAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ScheduleTableAdapter extends TypeAdapter<ScheduleTable> {
  @override
  final typeId = 7;

  @override
  ScheduleTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduleTable(
      rows: (fields[0] as List).cast<ScheduleRow>(),
      peWeekdays: fields[1] == null
          ? const {}
          : (fields[1] as Set).cast<Weekday>(),
      weekdayConfig: fields[2] == null
          ? const {}
          : (fields[2] as Map).cast<Weekday, bool>(),
    );
  }

  @override
  void write(BinaryWriter writer, ScheduleTable obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.rows)
      ..writeByte(1)
      ..write(obj.peWeekdays)
      ..writeByte(2)
      ..write(obj.weekdayConfig);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SavedScheduleAdapter extends TypeAdapter<SavedSchedule> {
  @override
  final typeId = 8;

  @override
  SavedSchedule read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedSchedule(
      id: fields[0] as String,
      name: fields[1] as String,
      createdAt: fields[2] as DateTime,
      table: fields[3] as ScheduleTable,
      semester: fields[4] as String?,
      themePreset: fields[5] as ThemePreset?,
      inputText: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SavedSchedule obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.table)
      ..writeByte(4)
      ..write(obj.semester)
      ..writeByte(5)
      ..write(obj.themePreset)
      ..writeByte(6)
      ..write(obj.inputText);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedScheduleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ThemePresetAdapter extends TypeAdapter<ThemePreset> {
  @override
  final typeId = 9;

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
          ? const {}
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

class ClassNoteAdapter extends TypeAdapter<ClassNote> {
  @override
  final typeId = 10;

  @override
  ClassNote read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClassNote(
      id: fields[0] as String,
      classCode: fields[1] as String,
      content: fields[2] as String,
      createdAt: fields[3] as DateTime,
      type: fields[4] == null ? NoteType.general : fields[4] as NoteType,
    );
  }

  @override
  void write(BinaryWriter writer, ClassNote obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.classCode)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassNoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NoteTypeAdapter extends TypeAdapter<NoteType> {
  @override
  final typeId = 11;

  @override
  NoteType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NoteType.general;
      case 1:
        return NoteType.homework;
      case 2:
        return NoteType.exam;
      default:
        return NoteType.general;
    }
  }

  @override
  void write(BinaryWriter writer, NoteType obj) {
    switch (obj) {
      case NoteType.general:
        writer.writeByte(0);
      case NoteType.homework:
        writer.writeByte(1);
      case NoteType.exam:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NotificationConfigAdapter extends TypeAdapter<NotificationConfig> {
  @override
  final typeId = 12;

  @override
  NotificationConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationConfig(
      enabled: fields[0] == null ? false : fields[0] as bool,
      minutesBefore: fields[1] == null ? 10 : (fields[1] as num).toInt(),
      activeDays: fields[2] == null
          ? const {}
          : (fields[2] as Set).cast<Weekday>(),
    );
  }

  @override
  void write(BinaryWriter writer, NotificationConfig obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.enabled)
      ..writeByte(1)
      ..write(obj.minutesBefore)
      ..writeByte(2)
      ..write(obj.activeDays);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BarSlotAdapter extends TypeAdapter<BarSlot> {
  @override
  final typeId = 13;

  @override
  BarSlot read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BarSlot(
      label: fields[0] as String,
      rowspan: fields[1] == null ? 1 : (fields[1] as num).toInt(),
      colspan: fields[2] == null ? 1 : (fields[2] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, BarSlot obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.label)
      ..writeByte(1)
      ..write(obj.rowspan)
      ..writeByte(2)
      ..write(obj.colspan);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarSlotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EmptySlotAdapter extends TypeAdapter<EmptySlot> {
  @override
  final typeId = 14;

  @override
  EmptySlot read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmptySlot(
      rowspan: fields[0] == null ? 1 : (fields[0] as num).toInt(),
      colspan: fields[1] == null ? 1 : (fields[1] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, EmptySlot obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.rowspan)
      ..writeByte(1)
      ..write(obj.colspan);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmptySlotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ColorDataAdapter extends TypeAdapter<ColorData> {
  @override
  final typeId = 15;

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

class TableThemeAdapter extends TypeAdapter<TableTheme> {
  @override
  final typeId = 16;

  @override
  TableTheme read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TableTheme(
      id: fields[0] as String,
      name: fields[1] as String,
      createdAt: fields[2] as DateTime,
      tableBorderColor: fields[3] as ColorData,
      tableBackgroundColor: fields[4] as ColorData,
      cornerRadius: (fields[5] as num).toDouble(),
      backgroundImagePath: fields[6] as String?,
      weekdayColors: (fields[7] as Map).cast<Weekday, ColorData>(),
    );
  }

  @override
  void write(BinaryWriter writer, TableTheme obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.tableBorderColor)
      ..writeByte(4)
      ..write(obj.tableBackgroundColor)
      ..writeByte(5)
      ..write(obj.cornerRadius)
      ..writeByte(6)
      ..write(obj.backgroundImagePath)
      ..writeByte(7)
      ..write(obj.weekdayColors);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TableThemeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
