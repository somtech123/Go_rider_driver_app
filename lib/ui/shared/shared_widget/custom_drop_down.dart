import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_rider_driver_app/utils/app_constant/app_color.dart';
import 'package:go_rider_driver_app/utils/utils/responsive_ui.dart';

class CustomDropDownForm extends StatelessWidget {
  const CustomDropDownForm({
    Key? key,
    required String selectedValue,
    required this.listOfValue,
    required this.header,
    required this.onChanged,
    this.validator,
    this.headerStyle,
  })  : _selectedValue = selectedValue,
        super(key: key);

  final String _selectedValue;
  final List<String> listOfValue;

  final void Function(dynamic) onChanged;

  final String? Function(String?)? validator;

  final String header;
  final TextStyle? headerStyle;

  @override
  Widget build(BuildContext context) {
    final sh = sHeight(context);
    final sw = sWidth(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColor.darkColor),
        ),
        SizedBox(
          height: 10.h,
        ),
        DropdownButtonFormField<String>(
          value: _selectedValue,
          hint: const Text(
            'choose one',
          ),
          isExpanded: true,
          onChanged: onChanged,
          enableFeedback: true,
          onSaved: (value) {},
          validator: validator,
          borderRadius: BorderRadius.circular(20.r),
          padding: EdgeInsets.zero,
          items: listOfValue.map<DropdownMenuItem<String>>((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(
                val,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            );
          }).toList(),
          decoration: InputDecoration(
              fillColor: AppColor.fillColor,
              filled: true,
              //constraints: BoxConstraints.expand(height: 56.h),
              counterText: '',
              errorStyle: TextStyle(fontSize: sh(12)),
              contentPadding:
                  EdgeInsets.fromLTRB(sw(12), sh(20), sw(12), sh(20)),
              hintText: 'nvv',
              hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColor.greyColor),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 1.w),
                  borderRadius: BorderRadius.circular(6.r)),
              errorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.transparent, width: 1.w)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.r),
                  borderSide:
                      BorderSide(color: Colors.transparent, width: 1.w)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.r),
                  borderSide:
                      BorderSide(color: Colors.transparent, width: 1.w))),
        )
      ],
    );
  }
}
