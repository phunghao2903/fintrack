import 'package:equatable/equatable.dart';
import 'package:fintrack/features/chart/expenses/expenses_data.dart';

abstract class ExpensesState extends Equatable {
  const ExpensesState();

  @override
  List<Object> get props => [];
}

class ExpensesInitial extends ExpensesState {}

class ExpensesLoading extends ExpensesState {}

class ExpensesLoaded extends ExpensesState {
  final List<ExpenseData> expenses;
  final double totalValue;
  final String activeCategory;
  final List<String> categories;

  const ExpensesLoaded({
    required this.expenses,
    required this.totalValue,
    required this.activeCategory,
    required this.categories,
  });

  @override
  List<Object> get props => [expenses, totalValue, activeCategory, categories];
}

class ExpensesError extends ExpensesState {
  final String message;

  const ExpensesError(this.message);

  @override
  List<Object> get props => [message];
}
