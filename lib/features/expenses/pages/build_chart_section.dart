import 'dart:math' as math;
import 'package:fintrack/core/theme/app_colors.dart';
import 'package:fintrack/features/expenses/datasources/expenses_data.dart';
import 'package:flutter/material.dart';

// Widget cho biểu đồ và chú giải
Widget buildChartSection(List<ExpenseData> expenses, double totalValue) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // Biểu đồ tròn
      SizedBox(
        width: 150,
        height: 150,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Custom painter để vẽ biểu đồ
            CustomPaint(
              size: const Size(150, 150),
              painter: PieChartPainter(expenses: expenses),
            ),
            // Text hiển thị tổng giá trị ở giữa
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "\$${totalValue.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const Text(
                  "Total",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(width: 20),
      // Chú giải
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: expenses.map((expense) {
            // Tính phần trăm cho từng khoản chi
            final percentage = totalValue > 0
                ? (expense.value / totalValue * 100).toStringAsFixed(1)
                : '0.0';

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  // Ô màu đại diện
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: expense.color,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Tên khoản chi
                  Expanded(
                    child: Text(
                      expense.name,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Phần trăm
                  Text(
                    "$percentage%",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    ],
  );
}

// Lớp Painter để vẽ biểu đồ tròn
class PieChartPainter extends CustomPainter {
  final List<ExpenseData> expenses;

  PieChartPainter({required this.expenses});

  @override
  void paint(Canvas canvas, Size size) {
    // Tính tổng giá trị
    double total = expenses.fold(0.0, (sum, item) => sum + item.value);

    if (total == 0) {
      // Nếu không có dữ liệu, vẽ vòng tròn xám
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.grey[800]!;

      final center = Offset(size.width / 2, size.height / 2);
      final radius = math.min(size.width / 2, size.height / 2);
      canvas.drawCircle(center, radius, paint);

      // Vẽ vòng tròn bên trong
      final innerCirclePaint = Paint()
        ..color = AppColors.background
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, radius * 0.6, innerCirclePaint);
      return;
    }

    // Bắt đầu vẽ từ góc 270 độ (12 giờ)
    double startAngle = -math.pi / 2;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2);
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Vẽ từng phần của biểu đồ
    for (var expense in expenses) {
      // Tính góc quét dựa trên tỷ lệ phần trăm
      // Tổng góc là 2π (360 độ = 100%)
      final sweepAngle = (expense.value / total) * 2 * math.pi;

      // Tạo paint cho phần này
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = expense.color;

      // Vẽ cung tròn
      canvas.drawArc(
        rect,
        startAngle,
        sweepAngle,
        true, // useCenter = true để vẽ hình quạt
        paint,
      );

      // Cập nhật góc bắt đầu cho phần tiếp theo
      startAngle += sweepAngle;
    }

    // Vẽ một vòng tròn ở giữa để tạo hiệu ứng donut chart
    final innerCirclePaint = Paint()
      ..color = AppColors.background
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.6, innerCirclePaint);
  }

  @override
  bool shouldRepaint(covariant PieChartPainter oldDelegate) {
    // Chỉ vẽ lại khi dữ liệu thay đổi
    return oldDelegate.expenses != expenses;
  }
}
