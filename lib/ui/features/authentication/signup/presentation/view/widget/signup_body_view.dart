import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_rider_driver_app/app/resouces/app_logger.dart';
import 'package:go_rider_driver_app/ui/features/authentication/signup/presentation/bloc/signup_bloc.dart';
import 'package:go_rider_driver_app/ui/features/authentication/signup/presentation/bloc/signup_event.dart';
import 'package:go_rider_driver_app/ui/features/authentication/signup/presentation/bloc/signup_state.dart';
import 'package:go_rider_driver_app/ui/shared/shared_widget/app_text_field.dart';
import 'package:go_rider_driver_app/ui/shared/shared_widget/primary_button.dart';
import 'package:go_rider_driver_app/ui/shared/shared_widget/social_button_widget.dart';
import 'package:go_rider_driver_app/utils/app_constant/app_color.dart';
import 'package:go_rider_driver_app/utils/app_constant/app_string.dart';
import 'package:go_router/go_router.dart';

var log = getLogger('SignUPScreen');

class SignUpBodyWidget extends StatefulWidget {
  const SignUpBodyWidget({super.key});

  @override
  State<SignUpBodyWidget> createState() => _SignUpBodyWidgetState();
}

class _SignUpBodyWidgetState extends State<SignUpBodyWidget> {
  static final formKey = GlobalKey<FormState>();

  late FocusNode passwordNode;
  late FocusNode usernameNode;
  late FocusNode emailNode;

  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final alphaRegex = RegExp(r'[a-zA-Z]');

  @override
  void initState() {
    super.initState();
    passwordNode = FocusNode();
    usernameNode = FocusNode();
    emailNode = FocusNode();
  }

  @override
  void dispose() {
    passwordNode.dispose();
    usernameNode.dispose();
    emailNode.dispose();

    passwordController.dispose();
    userNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SignUpBloc signupBloc = BlocProvider.of<SignUpBloc>(context);
    return BlocBuilder<SignUpBloc, SignUpState>(
      bloc: signupBloc,
      builder: (context, state) {
        return SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 25.h),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                Text(
                  AppStrings.fullName,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColor.darkColor),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  hintText: 'User Name',
                  focusNode: usernameNode,
                  controller: userNameController,
                  enableInteractiveSelection: false,
                  prefixIcon: const Icon(Icons.person),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"))
                  ],
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
                SizedBox(height: 20.h),
                Text(
                  AppStrings.enterEmail,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColor.darkColor),
                ),
                SizedBox(height: 20.h),
                AppTextField(
                  hintText: 'Email Address',
                  controller: emailController,
                  enableInteractiveSelection: false,
                  focusNode: emailNode,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.mail),
                  onFieldSubmitted: (p0) {
                    FocusScope.of(context).unfocus();
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'This Field is required';
                    } else if (!EmailValidator.validate(val)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                Text(
                  AppStrings.enterPassword,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColor.darkColor),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    obscureText: true,
                    enableInteractiveSelection: false,
                    controller: passwordController,
                    focusNode: passwordNode,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (p0) {
                      FocusScope.of(context).unfocus();
                    },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'This Field is required';
                      } else if (!val.contains(alphaRegex)) {
                        return "Password should contain numbers and alphabets";
                      }
                      return null;
                    }),
                SizedBox(height: 30.h),
                PrimaryButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      log.w('Creating account');
                      SystemChannels.textInput.invokeMethod('TextInput.hide');

                      signupBloc.add(SignUp(
                          context: context,
                          email: emailController.text,
                          password: passwordController.text,
                          username: userNameController.text));
                    }
                  },
                  label: AppStrings.siginup,
                ),
                SizedBox(height: 25.h),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    child: Text(
                      AppStrings.connect,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: AppColor.greyColor),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                socilaButton(
                  context,
                  ontap: () {
                    log.w('google clicked');
                  },
                  text: AppStrings.googleConnect,
                  leading: Image.asset(
                    'assets/images/google_icon.png',
                    height: 20.h,
                  ),
                ),
                SizedBox(height: 10.h),
                socilaButton(context, ontap: () {
                  log.w('facebook clicked');
                },
                    text: AppStrings.facebookConnect,
                    leading: SvgPicture.asset(
                      'assets/svgs/facebook.svg',
                    )),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                        text: "Already have an account?",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: AppColor.greyColor),
                        children: [
                          TextSpan(
                              text: ' Sign in',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  log.w('navigate to login screen');
                                  context.replace('/login');
                                },
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.primaryColor,
                                  ))
                        ]),
                  ),
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ));
      },
    );
  }
}
