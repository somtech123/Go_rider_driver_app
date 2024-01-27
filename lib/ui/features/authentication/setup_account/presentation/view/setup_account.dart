import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_rider_driver_app/ui/features/authentication/setup_account/presentation/view/widget/set_up_account_body.dart';
import 'package:go_rider_driver_app/ui/shared/shared_widget/circular_container.dart';
import 'package:go_rider_driver_app/ui/shared/top_widget/full_top_widget.dart';
import 'package:go_rider_driver_app/utils/app_constant/app_color.dart';

class SetUpAccountScreen extends StatelessWidget {
  const SetUpAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: WillPopScope(
        child: SafeArea(
          child: GestureDetector(
              child: Column(
            children: [
              Flexible(
                child: SizedBox(
                  height: height,
                  width: width,
                  child: Stack(children: [
                    CircularContainerWidget(
                      height: 100.h,
                      width: width,
                      borderRaduis: 0,
                      color: AppColor.primaryColor,
                      child: FullTopBarWidget(
                        title: RichText(
                          text: TextSpan(
                              text: 'Let\'s Get Started\n',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.whiteColor,
                                  ),
                              children: [
                                TextSpan(
                                    text: 'Drive and earn',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.whiteColor,
                                        ))
                              ]),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 80.h,
                      child: SizedBox(
                        height: height - 75.h,
                        width: width,
                        child: CircularContainerWidget(
                            color: AppColor.secondaryColor,
                            height: height - 75.h,
                            width: width,
                            borderRaduis: 30.r,
                            child: const SetUPAccountBody()),
                      ),
                    )
                  ]),
                ),
              ),
            ],
          )),
        ),
        onWillPop: () async {
          return false;
        },
      ),
    );
  }
}
