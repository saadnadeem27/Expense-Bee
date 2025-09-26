import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'goal.g.dart';

@HiveType(typeId: 7)
class Goal extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final double targetAmount;

  @HiveField(4)
  final double currentAmount;

  @HiveField(5)
  final DateTime targetDate;

  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  final int color;

  @HiveField(8)
  final String? imageUrl;

  @HiveField(9)
  final bool isActive;

  @HiveField(10)
  final GoalCategory category;

  const Goal({
    required this.id,
    required this.name,
    required this.description,
    required this.targetAmount,
    this.currentAmount = 0.0,
    required this.targetDate,
    required this.createdAt,
    this.color = 0xFF667eea,
    this.imageUrl,
    this.isActive = true,
    required this.category,
  });

  double get percentage =>
      targetAmount > 0 ? (currentAmount / targetAmount) * 100 : 0;
  double get remaining => targetAmount - currentAmount;
  bool get isCompleted => currentAmount >= targetAmount;
  int get daysRemaining => targetDate.difference(DateTime.now()).inDays;

  Goal copyWith({
    String? id,
    String? name,
    String? description,
    double? targetAmount,
    double? currentAmount,
    DateTime? targetDate,
    DateTime? createdAt,
    int? color,
    String? imageUrl,
    bool? isActive,
    GoalCategory? category,
  }) {
    return Goal(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      targetAmount: targetAmount ?? this.targetAmount,
      currentAmount: currentAmount ?? this.currentAmount,
      targetDate: targetDate ?? this.targetDate,
      createdAt: createdAt ?? this.createdAt,
      color: color ?? this.color,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        targetAmount,
        currentAmount,
        targetDate,
        createdAt,
        color,
        imageUrl,
        isActive,
        category,
      ];
}

@HiveType(typeId: 8)
enum GoalCategory {
  @HiveField(0)
  vacation,
  @HiveField(1)
  emergency,
  @HiveField(2)
  car,
  @HiveField(3)
  house,
  @HiveField(4)
  education,
  @HiveField(5)
  gadget,
  @HiveField(6)
  other,
}
