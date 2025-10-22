import 'package:fintrack/features/chart/models/chart_data.dart';

class ChartDataSource {
  // Daily
  static final List<ChartData> dailyData = [
    ChartData(day: "Mon", income: 500, expense: 300),
    ChartData(day: "Tue", income: 600, expense: 250),
    ChartData(day: "Wed", income: 100, expense: 600),
    ChartData(day: "Thu", income: 700, expense: 400),
    ChartData(day: "Fri", income: 650, expense: 350),
    ChartData(day: "Sat", income: 200, expense: 500),
    ChartData(day: "Sun", income: 750, expense: 450),
  ];

  // Weekly
  static final List<ChartData> weeklyData = [
    ChartData(day: "W1", income: 1000, expense: 2500),
    ChartData(day: "W2", income: 2500, expense: 1500),
    ChartData(day: "W3", income: 1500, expense: 2800),
    ChartData(day: "W4", income: 3300, expense: 1600),
  ];

  // Monthly
  static final List<ChartData> monthlyData = [
    ChartData(day: "1", income: 4500, expense: 3200),
    ChartData(day: "2", income: 4800, expense: 3100),
    ChartData(day: "3", income: 6200, expense: 4500),
    ChartData(day: "4", income: 5100, expense: 3300),
    ChartData(day: "5", income: 2600, expense: 4700),
    ChartData(day: "6", income: 6000, expense: 4000),
    ChartData(day: "7", income: 5800, expense: 4900),
    ChartData(day: "8", income: 3200, expense: 6200),
    ChartData(day: "9", income: 5900, expense: 3800),
    ChartData(day: "10", income: 6400, expense: 4300),
    ChartData(day: "11", income: 6300, expense: 4100),
    ChartData(day: "12", income: 6500, expense: 4400),
  ];

  // Yearly
  static final List<ChartData> yearlyData = [
    ChartData(day: "2020", income: 58000, expense: 42000),
    ChartData(day: "2021", income: 60000, expense: 43000),
    ChartData(day: "2022", income: 64000, expense: 46000),
    ChartData(day: "2023", income: 68000, expense: 49000),
    ChartData(day: "2024", income: 72000, expense: 51000),
  ];

  // Lấy dữ liệu theo filter
  static List<ChartData> getDataByFilter(String filter) {
    switch (filter) {
      case "Daily":
        return dailyData;
      case "Weekly":
        return weeklyData;
      case "Monthly":
        return monthlyData;
      case "Yearly":
        return yearlyData;
      default:
        return weeklyData;
    }
  }
}
