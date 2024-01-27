import 'package:go_rider_driver_app/app/helper/local_state_helper.dart';
import 'package:go_rider_driver_app/ui/features/authentication/login/data/user_model.dart';

class LoginState {
  LoadingState? loadingState;
  UserModel userModel;

  LoginState(
      {this.loadingState = LoadingState.initial, required this.userModel});

  LoginState copyWith({LoadingState? loadingState, UserModel? userModel}) =>
      LoginState(
          loadingState: loadingState ?? this.loadingState,
          userModel: userModel ?? this.userModel);

  List<Object?> get props => [loadingState, userModel];
}
