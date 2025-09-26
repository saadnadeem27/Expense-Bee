import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 0)
class Transaction extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final double amount;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final TransactionType type;

  @HiveField(6)
  final DateTime date;

  @HiveField(7)
  final String accountId;

  @HiveField(8)
  final String? imageUrl;

  @HiveField(9)
  final bool isRecurring;

  @HiveField(10)
  final RecurringPeriod? recurringPeriod;

  @HiveField(11)
  final DateTime? recurringEndDate;

  @HiveField(12)
  final Map<String, dynamic>? metadata;

  const Transaction({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.category,
    required this.type,
    required this.date,
    required this.accountId,
    this.imageUrl,
    this.isRecurring = false,
    this.recurringPeriod,
    this.recurringEndDate,
    this.metadata,
  });

  Transaction copyWith({
    String? id,
    String? title,
    String? description,
    double? amount,
    String? category,
    TransactionType? type,
    DateTime? date,
    String? accountId,
    String? imageUrl,
    bool? isRecurring,
    RecurringPeriod? recurringPeriod,
    DateTime? recurringEndDate,
    Map<String, dynamic>? metadata,
  }) {
    return Transaction(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      type: type ?? this.type,
      date: date ?? this.date,
      accountId: accountId ?? this.accountId,
      imageUrl: imageUrl ?? this.imageUrl,
      isRecurring: isRecurring ?? this.isRecurring,
      recurringPeriod: recurringPeriod ?? this.recurringPeriod,
      recurringEndDate: recurringEndDate ?? this.recurringEndDate,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        amount,
        category,
        type,
        date,
        accountId,
        imageUrl,
        isRecurring,
        recurringPeriod,
        recurringEndDate,
        metadata,
      ];
}

@HiveType(typeId: 1)
enum TransactionType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}

@HiveType(typeId: 2)
enum RecurringPeriod {
  @HiveField(0)
  daily,
  @HiveField(1)
  weekly,
  @HiveField(2)
  monthly,
  @HiveField(3)
  quarterly,
  @HiveField(4)
  yearly,
}
