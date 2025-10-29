class BudgetModel {
  final String name;
  final double spent;
  final double total;
  final bool isActive;

  BudgetModel({
    required this.name,
    required this.spent,
    required this.total,
    required this.isActive,
  });

  double get percent => (spent / total) * 100;

  String get status {
    if (percent < 80) return "Within";
    if (percent >= 80 && percent < 100) return "Risk";
    return "Overspending";
  }
}
