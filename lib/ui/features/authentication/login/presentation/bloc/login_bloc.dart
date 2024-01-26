import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_rider_driver_app/app/resouces/app_logger.dart';
import 'package:go_rider_driver_app/ui/features/authentication/login/presentation/bloc/login_state.dart';
import 'package:go_rider_driver_app/ui/features/authentication/login/presentation/bloc/lovin_event.dart';

var log = getLogger('Login_bloc');

class LoginBloc extends Bloc<LoginEvenet, LoginState> {
  LoginBloc() : super(LoginState()) {}
}
