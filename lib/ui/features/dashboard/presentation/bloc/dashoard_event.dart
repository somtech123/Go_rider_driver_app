import 'package:equatable/equatable.dart';

abstract class DashBoardEvent extends Equatable {}

class GetUserDetails extends DashBoardEvent {
  @override
  List<Object?> get props => [];
}
