import 'package:go_rider_driver_app/app/helper/local_state_helper.dart';

class LoginState {
  LoadingState? loadingState;

  LoginState({this.loadingState = LoadingState.initial});

  LoginState copyWith({LoadingState? loadingState}) =>
      LoginState(loadingState: loadingState ?? this.loadingState);

  List<Object?> get props => [loadingState];
}
