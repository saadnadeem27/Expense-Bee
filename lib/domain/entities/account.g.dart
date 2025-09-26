// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountAdapter extends TypeAdapter<Account> {
  @override
  final int typeId = 3;

  @override
  Account read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Account(
      id: fields[0] as String,
      name: fields[1] as String,
      type: fields[2] as AccountType,
      balance: fields[3] as double,
      currency: fields[4] as String,
      description: fields[5] as String?,
      iconData: fields[6] as String?,
      color: fields[7] as int,
      isActive: fields[8] as bool,
      createdAt: fields[9] as DateTime,
      updatedAt: fields[10] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Account obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.balance)
      ..writeByte(4)
      ..write(obj.currency)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.iconData)
      ..writeByte(7)
      ..write(obj.color)
      ..writeByte(8)
      ..write(obj.isActive)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AccountTypeAdapter extends TypeAdapter<AccountType> {
  @override
  final int typeId = 4;

  @override
  AccountType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AccountType.cash;
      case 1:
        return AccountType.bankAccount;
      case 2:
        return AccountType.creditCard;
      case 3:
        return AccountType.debitCard;
      case 4:
        return AccountType.digitalWallet;
      case 5:
        return AccountType.investment;
      default:
        return AccountType.cash;
    }
  }

  @override
  void write(BinaryWriter writer, AccountType obj) {
    switch (obj) {
      case AccountType.cash:
        writer.writeByte(0);
        break;
      case AccountType.bankAccount:
        writer.writeByte(1);
        break;
      case AccountType.creditCard:
        writer.writeByte(2);
        break;
      case AccountType.debitCard:
        writer.writeByte(3);
        break;
      case AccountType.digitalWallet:
        writer.writeByte(4);
        break;
      case AccountType.investment:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
