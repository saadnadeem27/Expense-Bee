import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'account.g.dart';

@HiveType(typeId: 3)
class Account extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final AccountType type;
  
  @HiveField(3)
  final double balance;
  
  @HiveField(4)
  final String currency;
  
  @HiveField(5)
  final String? description;
  
  @HiveField(6)
  final String? iconData;
  
  @HiveField(7)
  final int color;
  
  @HiveField(8)
  final bool isActive;
  
  @HiveField(9)
  final DateTime createdAt;
  
  @HiveField(10)
  final DateTime updatedAt;

  const Account({
    required this.id,
    required this.name,
    required this.type,
    required this.balance,
    required this.currency,
    this.description,
    this.iconData,
    this.color = 0xFF667eea,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  Account copyWith({
    String? id,
    String? name,
    AccountType? type,
    double? balance,
    String? currency,
    String? description,
    String? iconData,
    int? color,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
      description: description ?? this.description,
      iconData: iconData ?? this.iconData,
      color: color ?? this.color,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        balance,
        currency,
        description,
        iconData,
        color,
        isActive,
        createdAt,
        updatedAt,
      ];
}

@HiveType(typeId: 4)
enum AccountType {
  @HiveField(0)
  cash,
  @HiveField(1)
  bankAccount,
  @HiveField(2)
  creditCard,
  @HiveField(3)
  debitCard,
  @HiveField(4)
  digitalWallet,
  @HiveField(5)
  investment,
}