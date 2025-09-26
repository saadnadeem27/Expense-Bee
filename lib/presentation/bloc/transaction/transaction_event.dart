part of 'transaction_bloc.dart';

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