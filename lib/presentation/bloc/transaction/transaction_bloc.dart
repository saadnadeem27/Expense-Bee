import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/transaction.dart';
import '../../../data/dummy_data.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  List<Transaction> _allTransactions = [];

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
      // Load dummy data
      final accounts = DummyDataGenerator.generateAccounts();
      _allTransactions = DummyDataGenerator.generateTransactions(accounts);
      
      final totalIncome = _calculateTotalIncome(_allTransactions);
      final totalExpense = _calculateTotalExpense(_allTransactions);
      
      emit(TransactionLoaded(
        transactions: _allTransactions,
        filteredTransactions: _allTransactions,
        totalIncome: totalIncome,
        totalExpense: totalExpense,
      ));
    } catch (e) {
      emit(TransactionError(message: 'Failed to load transactions: ${e.toString()}'));
    }
  }

  void _onAddTransaction(
    AddTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    if (state is TransactionLoaded) {
      final currentState = state as TransactionLoaded;
      _allTransactions.add(event.transaction);
      _allTransactions.sort((a, b) => b.date.compareTo(a.date));
      
      final totalIncome = _calculateTotalIncome(_allTransactions);
      final totalExpense = _calculateTotalExpense(_allTransactions);
      
      emit(currentState.copyWith(
        transactions: List.from(_allTransactions),
        filteredTransactions: _applyFilters(_allTransactions, currentState),
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
      final index = _allTransactions.indexWhere((t) => t.id == event.transaction.id);
      
      if (index != -1) {
        _allTransactions[index] = event.transaction;
        _allTransactions.sort((a, b) => b.date.compareTo(a.date));
        
        final totalIncome = _calculateTotalIncome(_allTransactions);
        final totalExpense = _calculateTotalExpense(_allTransactions);
        
        emit(currentState.copyWith(
          transactions: List.from(_allTransactions),
          filteredTransactions: _applyFilters(_allTransactions, currentState),
          totalIncome: totalIncome,
          totalExpense: totalExpense,
        ));
      }
    }
  }

  void _onDeleteTransaction(
    DeleteTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    if (state is TransactionLoaded) {
      final currentState = state as TransactionLoaded;
      _allTransactions.removeWhere((t) => t.id == event.transactionId);
      
      final totalIncome = _calculateTotalIncome(_allTransactions);
      final totalExpense = _calculateTotalExpense(_allTransactions);
      
      emit(currentState.copyWith(
        transactions: List.from(_allTransactions),
        filteredTransactions: _applyFilters(_allTransactions, currentState),
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
      
      emit(currentState.copyWith(
        filteredTransactions: _applyFilters(_allTransactions, null,
          category: event.category,
          type: event.type,
          startDate: event.startDate,
          endDate: event.endDate,
          accountId: event.accountId,
        ),
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
      
      List<Transaction> searchResults = _allTransactions;
      
      if (event.query.isNotEmpty) {
        searchResults = _allTransactions.where((transaction) {
          return transaction.title.toLowerCase().contains(event.query.toLowerCase()) ||
                 transaction.description.toLowerCase().contains(event.query.toLowerCase()) ||
                 transaction.category.toLowerCase().contains(event.query.toLowerCase());
        }).toList();
      }
      
      emit(currentState.copyWith(
        filteredTransactions: searchResults,
      ));
    }
  }

  List<Transaction> _applyFilters(
    List<Transaction> transactions,
    TransactionLoaded? currentState, {
    String? category,
    TransactionType? type,
    DateTime? startDate,
    DateTime? endDate,
    String? accountId,
  }) {
    List<Transaction> filtered = List.from(transactions);
    
    final filterCategory = category ?? currentState?.filterCategory;
    final filterType = type ?? currentState?.filterType;
    final filterStartDate = startDate ?? currentState?.filterStartDate;
    final filterEndDate = endDate ?? currentState?.filterEndDate;
    
    if (filterCategory != null) {
      filtered = filtered.where((t) => t.category == filterCategory).toList();
    }
    
    if (filterType != null) {
      filtered = filtered.where((t) => t.type == filterType).toList();
    }
    
    if (filterStartDate != null) {
      filtered = filtered.where((t) => t.date.isAfter(filterStartDate) || 
                                      t.date.isAtSameMomentAs(filterStartDate)).toList();
    }
    
    if (filterEndDate != null) {
      filtered = filtered.where((t) => t.date.isBefore(filterEndDate) || 
                                      t.date.isAtSameMomentAs(filterEndDate)).toList();
    }
    
    if (accountId != null) {
      filtered = filtered.where((t) => t.accountId == accountId).toList();
    }
    
    return filtered;
  }

  double _calculateTotalIncome(List<Transaction> transactions) {
    return transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double _calculateTotalExpense(List<Transaction> transactions) {
    return transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, t) => sum + t.amount);
  }
}