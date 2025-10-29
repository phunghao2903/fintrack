import 'package:equatable/equatable.dart';
import 'package:fintrack/features/budget/models/budget_model.dart';

class BudgetState extends Equatable {
  final String selectedTab;
  final List<BudgetModel> budgets;
  final bool isLoading;

  const BudgetState({
    required this.selectedTab,
    required this.budgets,
    this.isLoading = false,
  });

  factory BudgetState.initial() =>
      const BudgetState(selectedTab: "Active", budgets: [], isLoading: true);

  BudgetState copyWith({
    String? selectedTab,
    List<BudgetModel>? budgets,
    bool? isLoading,
  }) {
    return BudgetState(
      selectedTab: selectedTab ?? this.selectedTab,
      budgets: budgets ?? this.budgets,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [selectedTab, budgets, isLoading];
}
