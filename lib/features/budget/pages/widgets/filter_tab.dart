import 'package:fintrack/core/theme/app_colors.dart';
import 'package:fintrack/core/theme/app_text_styles.dart';
import 'package:fintrack/core/utils/size_utils.dart';
import 'package:fintrack/features/budget/bloc/budget_bloc.dart';
import 'package:fintrack/features/budget/bloc/budget_event.dart';
import 'package:fintrack/features/budget/bloc/budget_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterTab extends StatelessWidget {
  const FilterTab({super.key});

  @override
  Widget build(BuildContext context) {
    final h = SizeUtils.height(context);
    final w = SizeUtils.width(context);

    return BlocBuilder<BudgetBloc, BudgetState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTabItem(context, "Active", state.selectedTab, w, h),
            _buildTabItem(context, "Closed", state.selectedTab, w, h),
          ],
        );
      },
    );
  }

  Widget _buildTabItem(
    BuildContext context,
    String label,
    String selectedTab,
    double w,
    double h,
  ) {
    final bool isSelected = selectedTab == label;

    return GestureDetector(
      onTap: () {
        context.read<BudgetBloc>().add(BudgetTabChanged(label));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTextStyles.heading2.copyWith(
              color: isSelected ? AppColors.main : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          SizedBox(height: h * 0.005),
          Container(
            height: h * 0.004,
            width: 0.4 * w,
            color: isSelected ? AppColors.main : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
