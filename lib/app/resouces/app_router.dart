import 'package:go_rider_driver_app/app/resouces/app_transition.dart';
import 'package:go_rider_driver_app/app/resouces/navigation_services.dart';
import 'package:go_rider_driver_app/ui/features/authentication/login/presentation/view/login_screen.dart';
import 'package:go_rider_driver_app/ui/features/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: NavigationService.navigatorKey,
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
          path: '/login',
          pageBuilder: (context, state) => CustomSlideTransition(
              child: const LoginScreen(), key: state.pageKey)),
    ],
  );
}
