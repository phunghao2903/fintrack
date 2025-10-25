import 'package:flutter/material.dart';

class ExpenseData {
  final String icon;
  final Color color;
  final String name;
  final double value; // Thuộc tính này rất quan trọng để tính toán
  final String amount;
  final String percentage;
  final bool isUp;

  ExpenseData({
    required this.icon,
    required this.color,
    required this.name,
    required this.value,
    required this.amount,
    required this.percentage,
    required this.isUp,
  });
}

final List<ExpenseData> expenses = [
  ExpenseData(
    icon: 'assets/images/Groeries.png',
    color: Colors.green,
    name: "Groceries",
    value: 167.30,
    amount: "\$167.30",
    percentage: "18%",
    isUp: true,
  ),
  ExpenseData(
    icon: 'assets/images/Shopping.png',
    color: Colors.orange,
    name: "Shopping",
    value: 245.50,
    amount: "\$245.50",
    percentage: "26%",
    isUp: false,
  ),
  ExpenseData(
    icon: 'assets/images/Food.png',
    color: Colors.red,
    name: "Food",
    value: 89.20,
    amount: "\$89.20",
    percentage: "9%",
    isUp: true,
  ),
  ExpenseData(
    icon: 'assets/images/Health.png',
    color: Colors.cyan,
    name: "Health",
    value: 55.00,
    amount: "\$55.00",
    percentage: "6%",
    isUp: false,
  ),
  ExpenseData(
    icon: 'assets/images/Travel.png',
    color: Colors.purple,
    name: "Travel",
    value: 310.00,
    amount: "\$310.00",
    percentage: "33%",
    isUp: true,
  ),
  ExpenseData(
    icon: 'assets/images/Taxi.png',
    color: Colors.blue,
    name: "Taxi",
    value: 76.97,
    amount: "\$76.97",
    percentage: "8%",
    isUp: false,
  ),
];
final double totalValue = expenses.fold(0, (sum, item) => sum + item.value);

final List<String> categories = ['Daily', 'Weekly', 'Monthly', 'Yearly'];
