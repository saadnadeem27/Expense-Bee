import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/transaction.dart';
import '../../../data/dummy_data.dart';

// Events
abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object?> get props => [];
}

class LoadTransactions extends TransactionEvent {
  const LoadTransactions();
}

class AddTransaction extends TransactionEvent {
  final Transaction transaction;

  const AddTransaction({required this.transaction});

  @override
  List<Object?> get props => [transaction];
}

class UpdateTransaction extends TransactionEvent {
  final Transaction transaction;

  const UpdateTransaction({required this.transaction});

  @override
  List<Object?> get props => [transaction];
}

class DeleteTransaction extends TransactionEvent {
  final String transactionId;

  const DeleteTransaction({required this.transactionId});

  @override
  List<Object?> get props => [transactionId];
}

class FilterTransactions extends TransactionEvent {
  final String? category;
  final TransactionType? type;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? accountId;

  const FilterTransactions({
    this.category,
    this.type,
    this.startDate,
    this.endDate,
    this.accountId,
  });

  @override
  List<Object?> get props => [category, type, startDate, endDate, accountId];
}

class SearchTransactions extends TransactionEvent {
  final String query;

  const SearchTransactions({required this.query});

  @override
  List<Object?> get props => [query];
}

// States
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

// BLoC
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(const TransactionInitial()) {
    on<LoadTransactions>(_onLoadTransactions);
    on<AddTransaction>(_onAddTransaction);
    on<UpdateTransaction>(_onUpdateTransaction);
    on<DeleteTransaction>(_onDeleteTransaction);
    on<FilterTransactions>(_onFilterTransactions);
    on<SearchTransactions>(_onSearchTransactions);
  }

  void _onLoadTransactions(
    LoadTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoading());

    try {
      // Simulate loading delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Generate dummy data
      final accounts = DummyDataGenerator.generateAccounts();
      final transactions = DummyDataGenerator.generateTransactions(accounts);

      final totalIncome = transactions
          .where((t) => t.type == TransactionType.income)
          .fold(0.0, (sum, t) => sum + t.amount);

      final totalExpense = transactions
          .where((t) => t.type == TransactionType.expense)
          .fold(0.0, (sum, t) => sum + t.amount);

      emit(TransactionLoaded(
        transactions: transactions,
        filteredTransactions: transactions,
        totalIncome: totalIncome,
        totalExpense: totalExpense,
      ));
    } catch (error) {
      emit(TransactionError(message: error.toString()));
    }
  }

  void _onAddTransaction(
    AddTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    if (state is TransactionLoaded) {
      final currentState = state as TransactionLoaded;

      final updatedTransactions =
          List<Transaction>.from(currentState.transactions)
            ..add(event.transaction)
            ..sort((a, b) => b.date.compareTo(a.date));

      final totalIncome = updatedTransactions
          .where((t) => t.type == TransactionType.income)
          .fold(0.0, (sum, t) => sum + t.amount);

      final totalExpense = updatedTransactions
          .where((t) => t.type == TransactionType.expense)
          .fold(0.0, (sum, t) => sum + t.amount);

      emit(currentState.copyWith(
        transactions: updatedTransactions,
        filteredTransactions: updatedTransactions,
        totalIncome: totalIncome,
        totalExpense: totalExpense,
      ));
    }
  }

  void _onUpdateTransaction(
    UpdateTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    if (state is TransactionLoaded) {
      final currentState = state as TransactionLoaded;

      final updatedTransactions = currentState.transactions.map((transaction) {
        return transaction.id == event.transaction.id
            ? event.transaction
            : transaction;
      }).toList();

      final totalIncome = updatedTransactions
          .where((t) => t.type == TransactionType.income)
          .fold(0.0, (sum, t) => sum + t.amount);

      final totalExpense = updatedTransactions
          .where((t) => t.type == TransactionType.expense)
          .fold(0.0, (sum, t) => sum + t.amount);

      emit(currentState.copyWith(
        transactions: updatedTransactions,
        filteredTransactions: updatedTransactions,
        totalIncome: totalIncome,
        totalExpense: totalExpense,
      ));
    }
  }

  void _onDeleteTransaction(
    DeleteTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    if (state is TransactionLoaded) {
      final currentState = state as TransactionLoaded;

      final updatedTransactions = currentState.transactions
          .where((transaction) => transaction.id != event.transactionId)
          .toList();

      final totalIncome = updatedTransactions
          .where((t) => t.type == TransactionType.income)
          .fold(0.0, (sum, t) => sum + t.amount);

      final totalExpense = updatedTransactions
          .where((t) => t.type == TransactionType.expense)
          .fold(0.0, (sum, t) => sum + t.amount);

      emit(currentState.copyWith(
        transactions: updatedTransactions,
        filteredTransactions: updatedTransactions,
        totalIncome: totalIncome,
        totalExpense: totalExpense,
      ));
    }
  }

  void _onFilterTransactions(
    FilterTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    if (state is TransactionLoaded) {
      final currentState = state as TransactionLoaded;

      var filteredTransactions =
          List<Transaction>.from(currentState.transactions);

      if (event.category != null && event.category!.isNotEmpty) {
        filteredTransactions = filteredTransactions
            .where((t) => t.category == event.category)
            .toList();
      }

      if (event.type != null) {
        filteredTransactions =
            filteredTransactions.where((t) => t.type == event.type).toList();
      }

      if (event.startDate != null) {
        filteredTransactions = filteredTransactions
            .where((t) =>
                t.date.isAfter(event.startDate!) ||
                t.date.isAtSameMomentAs(event.startDate!))
            .toList();
      }

      if (event.endDate != null) {
        filteredTransactions = filteredTransactions
            .where((t) =>
                t.date.isBefore(event.endDate!) ||
                t.date.isAtSameMomentAs(event.endDate!))
            .toList();
      }

      if (event.accountId != null && event.accountId!.isNotEmpty) {
        filteredTransactions = filteredTransactions
            .where((t) => t.accountId == event.accountId)
            .toList();
      }

      emit(currentState.copyWith(
        filteredTransactions: filteredTransactions,
        filterCategory: event.category,
        filterType: event.type,
        filterStartDate: event.startDate,
        filterEndDate: event.endDate,
      ));
    }
  }

  void _onSearchTransactions(
    SearchTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    if (state is TransactionLoaded) {
      final currentState = state as TransactionLoaded;

      if (event.query.isEmpty) {
        emit(currentState.copyWith(
            filteredTransactions: currentState.transactions));
        return;
      }

      final filteredTransactions = currentState.transactions
          .where((transaction) =>
              transaction.title
                  .toLowerCase()
                  .contains(event.query.toLowerCase()) ||
              transaction.description
                  .toLowerCase()
                  .contains(event.query.toLowerCase()) ||
              transaction.category
                  .toLowerCase()
                  .contains(event.query.toLowerCase()))
          .toList();

      emit(currentState.copyWith(filteredTransactions: filteredTransactions));
    }
  }
}
