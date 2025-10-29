import 'package:fintrack/features/budget/models/budget_model.dart';

class BudgetDataSource {
  static List<BudgetModel> budgets = [
    BudgetModel(
      name: "Monthly Budget",
      spent: 2500,
      total: 5000,
      isActive: true,
    ),
    BudgetModel(
      name: "Shopping Budget",
      spent: 4200,
      total: 5000,
      isActive: true,
    ),
    BudgetModel(
      name: "Shopping Budget",
      spent: 4200,
      total: 5000,
      isActive: true,
    ),
    BudgetModel(
      name: "Travel Budget",
      spent: 5500,
      total: 5000,
      isActive: false,
    ),
  ];
}
