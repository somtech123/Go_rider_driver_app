import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_rider_driver_app/app/helper/local_state_helper.dart';
import 'package:go_rider_driver_app/ui/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:go_rider_driver_app/ui/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:go_rider_driver_app/ui/features/dashboard/presentation/bloc/dashoard_event.dart';
import 'package:go_rider_driver_app/ui/features/dashboard/presentation/view/state_view/my_error_state_view.dart';
import 'package:go_rider_driver_app/ui/features/dashboard/presentation/view/state_view/my_loaded_state_view.dart';
import 'package:go_rider_driver_app/ui/features/dashboard/presentation/view/state_view/my_loading_state_view.dart';
import 'package:go_rider_driver_app/ui/features/dashboard/presentation/view/widget/home_drawer.dart';
import 'package:go_rider_driver_app/utils/app_constant/app_color.dart';
import 'package:go_rider_driver_app/utils/app_constant/app_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    BlocProvider.of<DashBoardBloc>(context).add(GetUserDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DashBoardBloc homeloc = BlocProvider.of<DashBoardBloc>(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
        title: Text(
          AppStrings.home,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColor.whiteColor),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.h),
            child: SvgPicture.asset(
              'assets/svgs/notification.svg',
              height: 20.h,
              width: 20.w,
            ),
          ),
        ],
        leadingWidth: 23.w,
        leading: BlocBuilder<DashBoardBloc, DashBoardState>(
          bloc: homeloc,
          builder: (context, state) {
            if (state.loadingState == LoadingState.loaded) {
              return SizedBox(
                width: 30.w,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.h),
                        child: GestureDetector(
                          onTap: () {
                            scaffoldKey.currentState!.openDrawer();
                          },
                          child: SvgPicture.asset(
                            'assets/svgs/handburger_svg.svg',
                            height: 25.h,
                            width: 25.w,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
      drawer: HomeScreenDrawer(scaffoldKey: scaffoldKey),
      body: WillPopScope(
        child: BlocListener<DashBoardBloc, DashBoardState>(
          listener: (context, state) {},
          bloc: homeloc,
          child: BlocBuilder<DashBoardBloc, DashBoardState>(
            builder: (context, state) {
              if (state.loadingState == LoadingState.loading) {
                return const MyDashboardLoadingView();
              } else if (state.loadingState == LoadingState.loaded) {
                return const MyDashboardLoadedView();
              } else if (state.loadingState == LoadingState.error) {
                return const MyDashboardScreenErrorView();
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
        onWillPop: () async {
          return false;
        },
      ),
    );
  }
}
