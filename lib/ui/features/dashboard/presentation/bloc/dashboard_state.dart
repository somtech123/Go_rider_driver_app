// ignore_for_file: override_on_non_overriding_member

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_rider_driver_app/app/helper/local_state_helper.dart';
import 'package:go_rider_driver_app/ui/features/authentication/login/data/user_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DashBoardState {
  LoadingState? loadingState;
  LatLng? currentLocation;

  LatLng? destinationLocation;

  Completer<GoogleMapController> mapController;

  UserModel? userModel;

  Set<Marker> markers;

  Map<PolylineId, Polyline> polyline;

  List<LatLng> plineCoordinate;

  TextEditingController pickUpAddress;

  TextEditingController destinationAddress;

  bool onCameraMove;

  DashBoardState({
    this.loadingState = LoadingState.initial,
    this.currentLocation,
    this.destinationLocation,
    this.userModel,
    required this.mapController,
    required this.markers,
    required this.plineCoordinate,
    required this.destinationAddress,
    required this.pickUpAddress,
    required this.polyline,
    required this.onCameraMove,
  });

  DashBoardState copyWith(
          {LoadingState? loadingState,
          LatLng? currentLocation,
          Completer<GoogleMapController>? mapController,
          UserModel? userModel,
          Set<Marker>? markers,
          List<LatLng>? plineCoordinate,
          TextEditingController? pickUpAddress,
          TextEditingController? destinationAddress,
          LatLng? destinationLocation,
          Map<PolylineId, Polyline>? polyline,
          bool? onCameraMove}) =>
      DashBoardState(
          loadingState: loadingState ?? this.loadingState,
          destinationLocation: destinationLocation ?? this.destinationLocation,
          currentLocation: currentLocation ?? this.currentLocation,
          mapController: mapController ?? this.mapController,
          userModel: userModel ?? this.userModel,
          markers: markers ?? this.markers,
          plineCoordinate: plineCoordinate ?? this.plineCoordinate,
          pickUpAddress: pickUpAddress ?? this.pickUpAddress,
          destinationAddress: destinationAddress ?? this.destinationAddress,
          polyline: polyline ?? this.polyline,
          onCameraMove: onCameraMove ?? this.onCameraMove);

  @override
  List<Object?> get props => [
        loadingState,
        currentLocation,
        mapController,
        userModel,
        markers,
        destinationLocation,
        plineCoordinate,
        destinationAddress,
        pickUpAddress,
        polyline,
        onCameraMove,
      ];
}
