import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_rider_driver_app/ui/features/authentication/setup_account/presentation/bloc/set_up_account_state.dart';
import 'package:go_rider_driver_app/ui/features/authentication/setup_account/presentation/bloc/setup_account_event.dart';

class SetupAccountBloc extends Bloc<SetUpAccountEvent, SetUpAccountState> {
  SetupAccountBloc() : super(SetUpAccountState()) {}
}
