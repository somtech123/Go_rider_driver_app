// ignore_for_file: use_build_context_synchronously, invalid_use_of_visible_for_testing_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_rider_driver_app/app/helper/local_state_helper.dart';
import 'package:go_rider_driver_app/app/resouces/app_logger.dart';
import 'package:go_rider_driver_app/ui/features/authentication/login/data/user_model.dart';
import 'package:go_rider_driver_app/ui/features/authentication/login/presentation/bloc/login_state.dart';
import 'package:go_rider_driver_app/ui/features/authentication/login/presentation/bloc/lovin_event.dart';
import 'package:go_rider_driver_app/ui/shared/shared_widget/custom_snackbar.dart';
import 'package:go_router/go_router.dart';

var log = getLogger('Login_bloc');

class LoginBloc extends Bloc<LoginEvenet, LoginState> {
  LoginBloc() : super(LoginState(userModel: UserModel())) {
    on<Login>((event, emit) async {
      await login(event.context, email: event.email, password: event.password);
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    log.w('staring the registration process');

    EasyLoading.show(status: 'loading...');

    emit(state.copyWith(loadingState: LoadingState.loading));

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      await getuserDetail();

      if (state.userModel.phoneNumber!.isEmpty &&
          state.userModel.ridePlate!.isEmpty) {
        context.push('/setupAccount');
      } else {
        EasyLoading.showSuccess('Successfully Login');

        context.replace('/homePage');
      }
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      showCustomSnackBar(message: e.message!);
    } catch (e) {
      EasyLoading.dismiss();

      showCustomSnackBar(message: e.toString());
    }
  }

  getuserDetail() async {
    emit(state.copyWith(userModel: UserModel()));
    try {
      User currentUser = _auth.currentUser!;
      DocumentSnapshot<Map<String, dynamic>> snap =
          await _firestore.collection("rider").doc(currentUser.uid).get();

      UserModel userModel = UserModel.fromJson(snap.data()!);

      log.w(userModel);

      emit(state.copyWith(userModel: userModel));
    } catch (e) {
      log.d(e);
    }
  }
}
