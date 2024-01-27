class UserModel {
  String? email;
  String? username;
  String? profileImage;
  DateTime? dateCreated;
  String? phoneNumber;
  String? rideColor;
  String? rideModel;
  String? ridePlate;
  String? noOfSeat;

  UserModel(
      {this.email,
      this.profileImage,
      this.username,
      this.dateCreated,
      this.phoneNumber,
      this.rideColor,
      this.rideModel,
      this.noOfSeat,
      this.ridePlate});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'],
      username: json['userName'],
      dateCreated: DateTime.parse(json['dateCreated']),
      phoneNumber: json['phoneNumber'],
      rideColor: json['rideColor'],
      rideModel: json['rideModel'],
      noOfSeat: json['noOfSeat'],
      ridePlate: json['ridePlate']);

  UserModel copyWith({
    String? email,
    String? username,
    String? profileImage,
    DateTime? dateCreated,
    String? phoneNumber,
    String? rideColor,
    String? rideModel,
    String? ridePlate,
    String? noOfSeat,
  }) =>
      UserModel(
          username: username ?? this.username,
          email: email ?? this.email,
          profileImage: profileImage ?? this.profileImage,
          dateCreated: dateCreated ?? this.dateCreated,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          rideColor: rideColor ?? this.rideColor,
          rideModel: rideModel ?? this.rideModel,
          ridePlate: ridePlate ?? this.ridePlate,
          noOfSeat: noOfSeat ?? this.noOfSeat);
}
