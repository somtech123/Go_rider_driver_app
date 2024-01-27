// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SetUpAccountEvent extends Equatable {}

class SelectSeatTotal extends SetUpAccountEvent {
  String selected;
  SelectSeatTotal({required this.selected});

  @override
  List<Object?> get props => [selected];
}

class UpdateRiderProfile extends SetUpAccountEvent {
  String carColor, carModel, carPlate, phoneNumber;

  final BuildContext context;

  UpdateRiderProfile(
    this.context, {
    required this.carColor,
    required this.carModel,
    required this.carPlate,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props =>
      [carColor, carModel, carPlate, phoneNumber, context];
}
