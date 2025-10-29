import 'package:equatable/equatable.dart';

abstract class BudgetEvent extends Equatable {
  const BudgetEvent();

  @override
  List<Object?> get props => [];
}

// Sự kiện đổi tab
class BudgetTabChanged extends BudgetEvent {
  final String selectedTab;
  const BudgetTabChanged(this.selectedTab);

  @override
  List<Object?> get props => [selectedTab];
}

// Sự kiện load dữ liệu
class LoadBudgets extends BudgetEvent {
  const LoadBudgets();
}
