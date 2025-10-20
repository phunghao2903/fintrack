import 'package:fintrack/core/theme/app_colors.dart';
import 'package:fintrack/core/theme/app_text_styles.dart';
import 'package:fintrack/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class AccountItem extends StatelessWidget {
  final String images;
  final String money;
  final String resource;
  AccountItem({
    required this.images,
    required this.money,
    required this.resource,
  });

  @override
  Widget build(BuildContext context) {
    final h = SizeUtils.height(context);
    final w = SizeUtils.width(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.02),
      child: Container(
        height: h * 0.17,
        width: w * 0.35,
        decoration: BoxDecoration(
          color: AppColors.widget,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.03,
            vertical: h * 0.02,
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(images),
              SizedBox(height: h * 0.01),
              Text(
                money,
                style: AppTextStyles.body1.copyWith(color: AppColors.white),
              ),
              SizedBox(height: h * 0.01),
              Text(
                resource,
                style: AppTextStyles.caption.copyWith(color: AppColors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
