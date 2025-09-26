// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionAdapter extends TypeAdapter<Transaction> {
  @override
  final int typeId = 0;

  @override
  Transaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transaction(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      amount: fields[3] as double,
      category: fields[4] as String,
      type: fields[5] as TransactionType,
      date: fields[6] as DateTime,
      accountId: fields[7] as String,
      imageUrl: fields[8] as String?,
      isRecurring: fields[9] as bool,
      recurringPeriod: fields[10] as RecurringPeriod?,
      recurringEndDate: fields[11] as DateTime?,
      metadata: (fields[12] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, Transaction obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.date)
      ..writeByte(7)
      ..write(obj.accountId)
      ..writeByte(8)
      ..write(obj.imageUrl)
      ..writeByte(9)
      ..write(obj.isRecurring)
      ..writeByte(10)
      ..write(obj.recurringPeriod)
      ..writeByte(11)
      ..write(obj.recurringEndDate)
      ..writeByte(12)
      ..write(obj.metadata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TransactionTypeAdapter extends TypeAdapter<TransactionType> {
  @override
  final int typeId = 1;

  @override
  TransactionType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TransactionType.income;
      case 1:
        return TransactionType.expense;
      default:
        return TransactionType.income;
    }
  }

  @override
  void write(BinaryWriter writer, TransactionType obj) {
    switch (obj) {
      case TransactionType.income:
        writer.writeByte(0);
        break;
      case TransactionType.expense:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecurringPeriodAdapter extends TypeAdapter<RecurringPeriod> {
  @override
  final int typeId = 2;

  @override
  RecurringPeriod read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RecurringPeriod.daily;
      case 1:
        return RecurringPeriod.weekly;
      case 2:
        return RecurringPeriod.monthly;
      case 3:
        return RecurringPeriod.quarterly;
      case 4:
        return RecurringPeriod.yearly;
      default:
        return RecurringPeriod.daily;
    }
  }

  @override
  void write(BinaryWriter writer, RecurringPeriod obj) {
    switch (obj) {
      case RecurringPeriod.daily:
        writer.writeByte(0);
        break;
      case RecurringPeriod.weekly:
        writer.writeByte(1);
        break;
      case RecurringPeriod.monthly:
        writer.writeByte(2);
        break;
      case RecurringPeriod.quarterly:
        writer.writeByte(3);
        break;
      case RecurringPeriod.yearly:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecurringPeriodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
