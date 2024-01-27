import 'package:flutter/material.dart';
import 'package:go_rider_driver_app/utils/app_constant/app_color.dart';

class MyDashboardLoadingView extends StatelessWidget {
  const MyDashboardLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColor.primaryColor),
    );
  }
}
