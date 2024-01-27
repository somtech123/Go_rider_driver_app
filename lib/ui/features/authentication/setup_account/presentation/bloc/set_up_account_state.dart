class SetUpAccountState {
  List<String> noOfSeat;
  String selectedValue;

  SetUpAccountState({required this.noOfSeat, required this.selectedValue});

  SetUpAccountState copyWith({
    List<String>? noOfSeat,
    String? selectedValue,
  }) =>
      SetUpAccountState(
          noOfSeat: noOfSeat ?? this.noOfSeat,
          selectedValue: selectedValue ?? this.selectedValue);

  List<Object?> get props => [noOfSeat, selectedValue];
}
