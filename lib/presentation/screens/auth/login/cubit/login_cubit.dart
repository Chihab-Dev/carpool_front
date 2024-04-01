import 'package:carpool/presentation/components/constants.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/screens/auth/login/cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginIntialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? phoneNumberErrorMessage;
  bool phoneNumberValid = false;
  bool passwordValid = false;

  bool isPasswordVisible = true;

  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(LoginChangePasswordVisibilityState());
  }

  void isPhoneNumberValid() {
    bool isPhoneNumberValid = PresentationConstances.isPhoneNumberValid(phoneNumberController.text);
    if (isPhoneNumberValid) {
      phoneNumberErrorMessage = null;
      phoneNumberValid = true;
    } else {
      phoneNumberErrorMessage = AppStrings.phoneNumberNotValid;
    }
    emit(LoginIsEmailValidState());
  }

  void login() {}
}
