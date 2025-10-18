import 'package:fintrack/core/theme/app_colors.dart';
import 'package:fintrack/core/theme/app_text_styles.dart';
import 'package:fintrack/core/utils/size_utils.dart';
import 'package:fl_chart/fl_chart.dart';
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          "assets/images/avartar.png",
                        ),
                        radius: 20,
                      ),
                      SizedBox(width: w * 0.02),
                      Text(
                        "Phung Hao",
                        style: AppTextStyles.body1.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset("assets/icons/notification.png",)
                    ],
                  )
                ],
              ),
              SizedBox(height: h*0.02,),
              Row(
                children: [
                  Text(
                    "Balance",
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.white

                    ), 
                  )
                ],
              ),
              SizedBox(height: h*0.01,), 
              Row(
                children: [
                  Text(
                    "\$2408.45",
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.main

                    ),
                  )
                ],
              ),
              SizedBox(height: h*0.01,),
              Container(
                height: h*0.2,
                width: w*0.9,
                decoration: BoxDecoration(
                  color: AppColors.widget,
                  borderRadius: BorderRadius.circular(10)
                  
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: w*0.05,vertical:h*0.03 ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Well done!",
                              style: AppTextStyles.heading2.copyWith(color: AppColors.white),
                                          
                            ),
                            SizedBox(height: h*0.01,),
                            Text(
                              "Your spending reduced by 2% from last month ",
                              style: AppTextStyles.caption.copyWith(color: AppColors.grey),
                                          
                            ),
                            SizedBox(height: h*0.01,),
                            Text(
                              "View Details",
                              style: AppTextStyles.body2.copyWith(color: AppColors.main),
                                          
                            ),
                          ],
                                          
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            // PieChart(
                            //   PieChartData(
                            //     sections: [
                            //       PieChartSectionData(
                            //         value: 20,
                            //         color: AppColors.main
                            //       )
                            //     ]
                            //   )
                              
                            // ),
                          ],
                                          
                        ),
                      )
                    ],
                  ),
                ),

              )



            ],
          ),
        ),
      ),
    );
  }
}
