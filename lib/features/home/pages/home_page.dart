import 'package:fintrack/core/theme/app_colors.dart';
import 'package:fintrack/core/theme/app_text_styles.dart';
import 'package:fintrack/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final h = SizeUtils.height(context);
    final w = SizeUtils.width(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        height: h,
        width: w,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.05,
            vertical: h * 0.05,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/avartar.png"),
                    radius: 20,
                    
                  ),
                  SizedBox( width: w*0.02,),
                  Text("Phung Hao",
                  style: AppTextStyles.body1.copyWith(color: AppColors.white),)
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
