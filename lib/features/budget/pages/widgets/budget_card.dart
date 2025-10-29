import 'package:fintrack/core/theme/app_colors.dart';
import 'package:fintrack/core/theme/app_text_styles.dart';
import 'package:fintrack/core/utils/size_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fintrack/features/budget/bloc/budget_bloc.dart';
import 'package:fintrack/features/budget/bloc/budget_state.dart';
import 'package:fintrack/features/budget/models/budget_model.dart';

class BudgetCard extends StatelessWidget {
  const BudgetCard({super.key});

  @override
  Widget build(BuildContext context) {
    final h = SizeUtils.height(context);
    final w = SizeUtils.width(context);

    return BlocBuilder<BudgetBloc, BudgetState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.main),
          );
        }

        final budgets = state.budgets;
        if (budgets.isEmpty) {
          return Center(
            child: Text(
              "No budgets available",
              style: AppTextStyles.body2.copyWith(color: AppColors.grey),
            ),
          );
        }

        return Column(
          children: budgets.map((budget) {
            final spentPercent = (budget.spent / budget.total) * 100;
            final remainingPercent = 100 - spentPercent;
            final status = budget.status;

            return Container(
              width: w,
              margin: EdgeInsets.only(bottom: h * 0.02),
              padding: EdgeInsets.all(w * 0.05),
              decoration: BoxDecoration(
                color: AppColors.widget,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        budget.name,
                        style: AppTextStyles.body2.copyWith(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "See All",
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h * 0.02),

                  // Body: Info + Chart
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Monthly \nspending limit",
                              style: AppTextStyles.heading2.copyWith(
                                color: AppColors.white,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: h * 0.01),
                            Text(
                              "Spend: \$${budget.spent.toStringAsFixed(0)} / \$${budget.total.toStringAsFixed(0)}",
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Pie Chart
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: h * 0.17,
                          child: PieChart(
                            PieChartData(
                              startDegreeOffset: -90,
                              sectionsSpace: 0,
                              centerSpaceRadius: h * 0.04,
                              sections: _buildChartSections(
                                status,
                                spentPercent,
                                remainingPercent,
                                h,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h * 0.03),

                  // Legend
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLegendItem(context, AppColors.main, "Within"),
                      SizedBox(width: w * 0.05),
                      _buildLegendItem(context, AppColors.brightOrange, "Risk"),
                      SizedBox(width: w * 0.05),
                      _buildLegendItem(context, AppColors.blue, "Overspending"),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  List<PieChartSectionData> _buildChartSections(
    String status,
    double spentPercent,
    double remainingPercent,
    double h,
  ) {
    if (status == "Overspending") {
      // Nếu đã vượt chi: chỉ 1 section 100%
      return [
        PieChartSectionData(
          color: AppColors.blue,
          value: 100,
          radius: h * 0.04,
          showTitle: false,
        ),
      ];
    } else {
      // Các trạng thái khác: Within / Risk
      return [
        PieChartSectionData(
          color: _getColorForStatus(status),
          value: spentPercent,
          radius: h * 0.04,
          showTitle: false,
        ),
        PieChartSectionData(
          color: status == "Within"
              ? const Color.fromARGB(255, 61, 87, 51)
              : const Color.fromARGB(255, 144, 52, 9),
          value: remainingPercent,
          radius: h * 0.04,
          showTitle: false,
        ),
      ];
    }
  }

  Color _getColorForStatus(String status) {
    switch (status) {
      case "Within":
        return AppColors.main;
      case "Risk":
        return AppColors.brightOrange;
      case "Overspending":
        return AppColors.blue;
      default:
        return AppColors.grey;
    }
  }

  Widget _buildLegendItem(BuildContext context, Color color, String label) {
    final h = SizeUtils.height(context);
    final w = SizeUtils.width(context);

    return Row(
      children: [
        Container(
          width: w * 0.04,
          height: h * 0.02,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: w * 0.015),
        Text(label, style: AppTextStyles.body2.copyWith(color: AppColors.grey)),
      ],
    );
  }
}
