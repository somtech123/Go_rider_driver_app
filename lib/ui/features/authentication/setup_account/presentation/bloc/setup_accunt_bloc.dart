// ignore_for_file: invalid_use_of_visible_for_testing_member, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_rider_driver_app/app/resouces/app_logger.dart';
import 'package:go_rider_driver_app/ui/features/authentication/setup_account/presentation/bloc/set_up_account_state.dart';
import 'package:go_rider_driver_app/ui/features/authentication/setup_account/presentation/bloc/setup_account_event.dart';
import 'package:go_rider_driver_app/ui/shared/shared_widget/custom_snackbar.dart';
import 'package:go_router/go_router.dart';

var log = getLogger('SetUpAccount_bloc');

class SetupAccountBloc extends Bloc<SetUpAccountEvent, SetUpAccountState> {
  SetupAccountBloc()
      : super(SetUpAccountState(
            noOfSeat: ['1', '2', '3', '4', '5', '6'], selectedValue: '3')) {
    on<SelectSeatTotal>((event, emit) => selectNoOfSeat(event.selected));

    on<UpdateRiderProfile>((event, emit) async {
      await updateRiderProfile(event.context,
          phoneNumber: event.phoneNumber,
          rideModel: event.carModel,
          rideColor: event.carColor,
          ridePLate: event.carPlate);
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  selectNoOfSeat(String seatCount) {
    emit(state.copyWith(selectedValue: seatCount));

    log.w(seatCount);
  }

  updateRiderProfile(
    BuildContext context, {
    required String phoneNumber,
    required String rideModel,
    required String rideColor,
    required String ridePLate,
  }) async {
    EasyLoading.show(status: 'loading...');

    log.w('setting up account');

    Map<String, dynamic> payload() => {
          'phoneNumber': phoneNumber,
          'rideModel': rideModel,
          'rideColor': rideColor,
          'ridePlate': ridePLate,
          'noOfSeat': state.selectedValue
        };

    try {
      await _firestore
          .collection("rider")
          .doc(_auth.currentUser!.uid)
          .update(payload());

      EasyLoading.showSuccess('Successfully Signup');

      context.replace('/homePage');
    } catch (e) {
      EasyLoading.dismiss();

      showCustomSnackBar(message: e.toString());
    }
  }
}
