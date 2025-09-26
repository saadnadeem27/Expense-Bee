import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'budget.g.dart';

@HiveType(typeId: 5)
class Budget extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final String category;
  
  @HiveField(3)
  final double amount;
  
  @HiveField(4)
  final double spent;
  
  @HiveField(5)
  final BudgetPeriod period;
  
  @HiveField(6)
  final DateTime startDate;
  
  @HiveField(7)
  final DateTime endDate;
  
  @HiveField(8)
  final bool isActive;
  
  @HiveField(9)
  final int color;
  
  @HiveField(10)
  final String? description;
  
  @HiveField(11)
  final bool alertEnabled;
  
  @HiveField(12)
  final double alertPercentage;

  const Budget({
    required this.id,
    required this.name,
    required this.category,
    required this.amount,
    this.spent = 0.0,
    required this.period,
    required this.startDate,
    required this.endDate,
    this.isActive = true,
    this.color = 0xFF667eea,
    this.description,
    this.alertEnabled = true,
    this.alertPercentage = 80.0,
  });

  double get percentage => amount > 0 ? (spent / amount) * 100 : 0;
  double get remaining => amount - spent;
  bool get isExceeded => spent > amount;

  Budget copyWith({
    String? id,
    String? name,
    String? category,
    double? amount,
    double? spent,
    BudgetPeriod? period,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
    int? color,
    String? description,
    bool? alertEnabled,
    double? alertPercentage,
  }) {
    return Budget(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      spent: spent ?? this.spent,
      period: period ?? this.period,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      color: color ?? this.color,
      description: description ?? this.description,
      alertEnabled: alertEnabled ?? this.alertEnabled,
      alertPercentage: alertPercentage ?? this.alertPercentage,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        amount,
        spent,
        period,
        startDate,
        endDate,
        isActive,
        color,
        description,
        alertEnabled,
        alertPercentage,
      ];
}

@HiveType(typeId: 6)
enum BudgetPeriod {
  @HiveField(0)
  weekly,
  @HiveField(1)
  monthly,
  @HiveField(2)
  quarterly,
  @HiveField(3)
  yearly,
}