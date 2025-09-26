// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalAdapter extends TypeAdapter<Goal> {
  @override
  final int typeId = 7;

  @override
  Goal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Goal(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      targetAmount: fields[3] as double,
      currentAmount: fields[4] as double,
      targetDate: fields[5] as DateTime,
      createdAt: fields[6] as DateTime,
      color: fields[7] as int,
      imageUrl: fields[8] as String?,
      isActive: fields[9] as bool,
      category: fields[10] as GoalCategory,
    );
  }

  @override
  void write(BinaryWriter writer, Goal obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.targetAmount)
      ..writeByte(4)
      ..write(obj.currentAmount)
      ..writeByte(5)
      ..write(obj.targetDate)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.color)
      ..writeByte(8)
      ..write(obj.imageUrl)
      ..writeByte(9)
      ..write(obj.isActive)
      ..writeByte(10)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GoalCategoryAdapter extends TypeAdapter<GoalCategory> {
  @override
  final int typeId = 8;

  @override
  GoalCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return GoalCategory.vacation;
      case 1:
        return GoalCategory.emergency;
      case 2:
        return GoalCategory.car;
      case 3:
        return GoalCategory.house;
      case 4:
        return GoalCategory.education;
      case 5:
        return GoalCategory.gadget;
      case 6:
        return GoalCategory.other;
      default:
        return GoalCategory.vacation;
    }
  }

  @override
  void write(BinaryWriter writer, GoalCategory obj) {
    switch (obj) {
      case GoalCategory.vacation:
        writer.writeByte(0);
        break;
      case GoalCategory.emergency:
        writer.writeByte(1);
        break;
      case GoalCategory.car:
        writer.writeByte(2);
        break;
      case GoalCategory.house:
        writer.writeByte(3);
        break;
      case GoalCategory.education:
        writer.writeByte(4);
        break;
      case GoalCategory.gadget:
        writer.writeByte(5);
        break;
      case GoalCategory.other:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
