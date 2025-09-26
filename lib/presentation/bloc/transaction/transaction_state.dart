part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object?> get props => [];
}

class TransactionInitial extends TransactionState {
  const TransactionInitial();
}

class TransactionLoading extends TransactionState {
  const TransactionLoading();
}

class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;
  final List<Transaction> filteredTransactions;
  final double totalIncome;
  final double totalExpense;
  final String? filterCategory;
  final TransactionType? filterType;
  final DateTime? filterStartDate;
  final DateTime? filterEndDate;

  const TransactionLoaded({
    required this.transactions,
    required this.filteredTransactions,
    required this.totalIncome,
    required this.totalExpense,
    this.filterCategory,
    this.filterType,
    this.filterStartDate,
    this.filterEndDate,
  });

  double get balance => totalIncome - totalExpense;

  TransactionLoaded copyWith({
    List<Transaction>? transactions,
    List<Transaction>? filteredTransactions,
    double? totalIncome,
    double? totalExpense,
    String? filterCategory,
    TransactionType? filterType,
    DateTime? filterStartDate,
    DateTime? filterEndDate,
  }) {
    return TransactionLoaded(
      transactions: transactions ?? this.transactions,
      filteredTransactions: filteredTransactions ?? this.filteredTransactions,
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpense: totalExpense ?? this.totalExpense,
      filterCategory: filterCategory ?? this.filterCategory,
      filterType: filterType ?? this.filterType,
      filterStartDate: filterStartDate ?? this.filterStartDate,
      filterEndDate: filterEndDate ?? this.filterEndDate,
    );
  }

  @override
  List<Object?> get props => [
        transactions,
        filteredTransactions,
        totalIncome,
        totalExpense,
        filterCategory,
        filterType,
        filterStartDate,
        filterEndDate,
      ];
}

class TransactionError extends TransactionState {
  final String message;

  const TransactionError({required this.message});

  @override
  List<Object?> get props => [message];
}
