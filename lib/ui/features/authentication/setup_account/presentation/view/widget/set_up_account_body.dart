import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_rider_driver_app/ui/features/authentication/setup_account/presentation/bloc/set_up_account_state.dart';
import 'package:go_rider_driver_app/ui/features/authentication/setup_account/presentation/bloc/setup_account_event.dart';
import 'package:go_rider_driver_app/ui/features/authentication/setup_account/presentation/bloc/setup_accunt_bloc.dart';
import 'package:go_rider_driver_app/ui/shared/shared_widget/app_text_field.dart';
import 'package:go_rider_driver_app/ui/shared/shared_widget/custom_drop_down.dart';
import 'package:go_rider_driver_app/ui/shared/shared_widget/primary_button.dart';
import 'package:go_rider_driver_app/utils/app_constant/app_color.dart';
import 'package:go_rider_driver_app/utils/app_constant/app_string.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/helpers.dart';

class SetUPAccountBody extends StatefulWidget {
  const SetUPAccountBody({super.key});

  @override
  State<SetUPAccountBody> createState() => _SetUPAccountBodyState();
}

class _SetUPAccountBodyState extends State<SetUPAccountBody> {
  TextEditingController phoneController = TextEditingController();

  TextEditingController carModelController = TextEditingController();

  TextEditingController carColorController = TextEditingController();

  TextEditingController carPlateController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  late List<Country> _countryList;
  late Country _selectedCountry;
  late String number;

  late List<Country> filteredCountries;
  @override
  void initState() {
    super.initState();
    _countryList = countries;
    filteredCountries = _countryList;
    number =
        //widget.initialValue ??
        '';
    if (number.startsWith('+')) {
      number = number.substring(1);
      // parse initial value
      _selectedCountry = countries.firstWhere(
          (country) => number.startsWith(country.fullCountryCode),
          orElse: () => _countryList.first);

      // remove country code from the initial number value
      number = number.replaceFirst(
          RegExp("^${_selectedCountry.fullCountryCode}"), "");
    } else {
      _selectedCountry = _countryList.firstWhere((item) => item.code == ('NG'),
          orElse: () => _countryList.first);

      // remove country code from the initial number value
      if (number.startsWith('+')) {
        number = number.replaceFirst(
            RegExp("^\\+${_selectedCountry.fullCountryCode}"), "");
      } else {
        number = number.replaceFirst(
            RegExp("^${_selectedCountry.fullCountryCode}"), "");
      }
    }
  }

  Future<void> _changeCountry() async {
    filteredCountries = _countryList;
    await showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) => StatefulBuilder(
        builder: (ctx, setState) => CountryPickerDialog(
          languageCode: 'en',
          filteredCountries: filteredCountries,
          searchText: 'Search Country',
          countryList: _countryList,
          selectedCountry: _selectedCountry,
          onCountryChanged: (Country country) {
            _selectedCountry = country;

            setState(() {});
          },
        ),
      ),
    );
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    carPlateController.dispose();
    carColorController.dispose();
    carModelController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SetupAccountBloc setupAccountBloc =
        BlocProvider.of<SetupAccountBloc>(context);

    return BlocBuilder<SetupAccountBloc, SetUpAccountState>(
      bloc: setupAccountBloc,
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.h),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Become a Driver',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: AppColor.darkColor,
                        ),
                  ),
                  Text(
                    AppStrings.becomeDriver,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppColor.greyColor,
                        ),
                  ),
                  SizedBox(height: 20.h),

                  //********************* beginning Custom phone number textfield with validation*******************//
                  Text(
                    AppStrings.phone,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColor.darkColor),
                  ),
                  TextFormField(
                    controller: phoneController,
                    validator: (value) {
                      if (value == null || !isNumeric(value)) {
                        return 'Invalid phone number';
                      } else if (value.length >= _selectedCountry.minLength &&
                          value.length <= _selectedCountry.maxLength) {
                        return null;
                      }
                      return 'Invalid phone number';
                    },
                    initialValue: (phoneController == null) ? number : null,
                    autofillHints: const [
                      AutofillHints.telephoneNumberNational
                    ],
                    enabled: true,
                    decoration: InputDecoration(
                        hintText: 'Phone Number',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: AppColor.greyColor),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 1),
                            borderRadius: BorderRadius.circular(6.0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 2)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 1),
                            borderRadius: BorderRadius.circular(6.0)),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                        prefixIcon: _buildFlagsButton(),
                        fillColor: AppColor.fillColor,
                        filled: true),
                    maxLength: _selectedCountry.maxLength,
                  ),

                  //********************* end Custom phone number textfield with validation*******************//

                  Text(
                    AppStrings.carModel,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColor.darkColor),
                  ),
                  SizedBox(height: 10.h),
                  AppTextField(
                    hintText: AppStrings.carModel,
                    enableInteractiveSelection: false,
                    prefixIcon: const Icon(Icons.car_crash),
                    controller: carModelController,
                    maxLength: 11,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'This Field is required';
                      }
                      return null;
                    },
                    onFieldSubmitted: (p0) {
                      FocusScope.of(context).unfocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),

                  //car color
                  SizedBox(height: 20.h),
                  Text(
                    AppStrings.carColor,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColor.darkColor),
                  ),
                  SizedBox(height: 10.h),
                  AppTextField(
                    hintText: AppStrings.carColor,
                    enableInteractiveSelection: false,
                    maxLength: 11,
                    controller: carColorController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"))
                    ],
                    prefixIcon: const Icon(Icons.color_lens_outlined),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'This Field is required';
                      }
                      return null;
                    },
                    onFieldSubmitted: (p0) {
                      FocusScope.of(context).unfocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),

                  //car plates
                  SizedBox(height: 20.h),
                  Text(
                    AppStrings.carPLate,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColor.darkColor),
                  ),
                  SizedBox(height: 10.h),
                  AppTextField(
                    hintText: AppStrings.carPLate,
                    enableInteractiveSelection: false,
                    maxLength: 11,
                    controller: carPlateController,
                    textCapitalization: TextCapitalization.characters,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"))
                    ],
                    prefixIcon: const Icon(Icons.car_rental_outlined),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'This Field is required';
                      }
                      return null;
                    },
                    onFieldSubmitted: (p0) {
                      FocusScope.of(context).unfocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),

                  SizedBox(height: 10.h),
                  CustomDropDownForm(
                    listOfValue: state.noOfSeat,
                    selectedValue: state.selectedValue,
                    onChanged: (val) =>
                        setupAccountBloc.add(SelectSeatTotal(selected: val)),
                    header: 'No of Seat',
                  ),

                  SizedBox(height: 40.h),

                  PrimaryButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        setupAccountBloc.add(UpdateRiderProfile(
                          context,
                          carColor: carColorController.text.trim(),
                          carModel: carModelController.text.trim(),
                          carPlate: carPlateController.text.trim(),
                          phoneNumber: phoneController.text.trim(),
                        ));
                      }
                    },
                    label: AppStrings.next,
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Container _buildFlagsButton() {
    return Container(
      margin: EdgeInsets.zero,
      child: DecoratedBox(
        decoration: const BoxDecoration(),
        child: InkWell(
          onTap: _changeCountry,
          child: Padding(
            padding: EdgeInsets.all(10.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 4.w,
                ),
                const Icon(Icons.arrow_drop_down),
                SizedBox(width: 4.w),
                Text(
                  _selectedCountry.flag,
                  style: const TextStyle(fontSize: 18),
                ),
                SizedBox(width: 4.w),
                FittedBox(
                  child: Text(
                    '+${_selectedCountry.dialCode}',
                    //style: widget.dropdownTextStyle,
                  ),
                ),
                SizedBox(width: 8.w),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
