// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_rider_driver_app/app/helper/local_state_helper.dart';
import 'package:go_rider_driver_app/app/resouces/app_logger.dart';
import 'package:go_rider_driver_app/ui/features/authentication/login/data/user_model.dart';
import 'package:go_rider_driver_app/ui/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:go_rider_driver_app/ui/features/dashboard/presentation/bloc/dashoard_event.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

var log = getLogger('Home_bloc');

class DashBoardBloc extends Bloc<DashBoardEvent, DashBoardState> {
  DashBoardBloc()
      : super(DashBoardState(
            mapController: Completer<GoogleMapController>(),
            loadingState: LoadingState.initial,
            markers: {},
            plineCoordinate: [],
            polyline: {},
            pickUpAddress: TextEditingController(),
            destinationAddress: TextEditingController(),
            onCameraMove: false)) {
    on<GetUserDetails>((event, emit) async {
      await getUserDetail();
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> close() {
    state.mapController = Completer();
    return super.close();
  }

  getUserDetail() async {
    emit(state.copyWith(
        loadingState: LoadingState.loading, userModel: UserModel()));

    try {
      User currentUser = _auth.currentUser!;
      DocumentSnapshot<Map<String, dynamic>> snap =
          await _firestore.collection("rider").doc(currentUser.uid).get();

      UserModel userModel = UserModel.fromJson(snap.data()!);

      log.w(userModel);

      emit(state.copyWith(
          loadingState: LoadingState.loaded, userModel: userModel));
    } catch (e) {
      log.d(e);

      emit(state.copyWith(
          loadingState: LoadingState.error, userModel: UserModel()));
    }
  }
}
