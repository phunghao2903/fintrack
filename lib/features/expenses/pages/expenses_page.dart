import 'package:fintrack/core/theme/app_text_styles.dart';
import 'package:fintrack/features/expenses/bloc/expenses_bloc.dart';
import 'package:fintrack/features/expenses/bloc/expenses_event.dart';
import 'package:fintrack/features/expenses/bloc/expenses_state.dart';
import 'package:fintrack/features/expenses/pages/build_chart_section.dart';
import 'package:fintrack/features/expenses/pages/build_expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fintrack/core/theme/app_colors.dart';
import 'package:fintrack/core/utils/size_utils.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ExpensesBloc>().add(LoadExpensesData());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = SizeUtils.height(context);
    final w = SizeUtils.width(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.01),
        child: BlocConsumer<ExpensesBloc, ExpensesState>(
          listener: (context, state) {
            // Xử lý side effects ở đây
            if (state is ExpensesError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Lỗi: ${state.message}'),
                  backgroundColor: AppColors.red,
                ),
              );
            }

            if (state is ExpensesLoaded && state.expenses.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Không tìm thấy khoản chi tiêu nào'),
                  backgroundColor: AppColors.orange,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ExpensesInitial || state is ExpensesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ExpensesLoaded) {
              return _buildContent(context, state, h, w);
            } else if (state is ExpensesError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: AppColors.red,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Đã xảy ra lỗi: ${state.message}',
                      style: const TextStyle(color: AppColors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ExpensesBloc>().add(LoadExpensesData());
                      },
                      child: const Text('Thử lại'),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ExpensesLoaded state,
    double h,
    double w,
  ) {
    // Lấy danh sách categories từ state thay vì hardcode
    final List<String> categories = state.categories;

    // Nếu state không có activeCategory, mặc định là phần tử đầu tiên
    final String activeCategory = state.activeCategory;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              "Expenses",
              style: AppTextStyles.heading2.copyWith(color: AppColors.white),
            ),
          ],
        ),

        /// search bar - Thay đổi ở đây
        Container(
          padding: const EdgeInsets.only(bottom: 20, top: 20),
          child: TextField(
            controller: _searchController,
            style: const TextStyle(color: AppColors.white),
            cursorColor: AppColors.white,
            // Thêm sự kiện onSubmitted để xử lý khi người dùng nhấn Enter
            onSubmitted: (value) {
              context.read<ExpensesBloc>().add(SearchExpenses(value));
            },
            decoration: InputDecoration(
              // prefixIcon: const Icon(Icons.search, color: Colors.white70),
              // Thêm icon tìm kiếm bên phải có thể nhấn để tìm kiếm
              suffixIcon: IconButton(
                icon: const Icon(Icons.search, color: AppColors.white),
                onPressed: () {
                  // Gửi sự kiện tìm kiếm khi nhấn vào icon
                  context.read<ExpensesBloc>().add(
                    SearchExpenses(_searchController.text),
                  );
                },
              ),
              hintText: "Search",
              hintStyle: const TextStyle(color: AppColors.grey),
              filled: true,
              fillColor: AppColors.widget,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // Category navbar
        SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(categories.length, (index) {
              final category = categories[index];
              final isSelected = activeCategory == category;

              return GestureDetector(
                onTap: () {
                  context.read<ExpensesBloc>().add(
                    FilterExpensesByCategory(category),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? AppColors.main : AppColors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 1,
                      width: 40,
                      color: isSelected ? AppColors.main : AppColors.background,
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 20),

        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Biểu đồ và chú giải với dữ liệu từ BLoC
                buildChartSection(state.expenses, state.totalValue),
                const SizedBox(height: 20),
                // Custom widget để hiển thị danh sách chi tiêu từ BLoC
                state.expenses.isEmpty
                    ? buildEmptyExpenseList()
                    : buildExpenseList(state.expenses),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
