import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_rider_driver_app/utils/app_constant/app_color.dart';

class MyDashboardScreenErrorView extends StatelessWidget {
  const MyDashboardScreenErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_sharp,
              color: AppColor.primaryColor,
            ),
            SizedBox(height: 20.w),
            Text("Error! Couldn't load user detail",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w400))
          ],
        ),
      ),
    );
  }
}
