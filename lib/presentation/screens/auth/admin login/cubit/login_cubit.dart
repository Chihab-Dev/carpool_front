import 'package:carpool/app/localizations.dart';
import 'package:carpool/app/service_locator.dart';
import 'package:carpool/app/shared_prefrences.dart';
import 'package:carpool/domain/usecase/admin/login_usecase.dart';
import 'package:carpool/presentation/components/constants.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:carpool/presentation/screens/admin/screens/main.dart';
import 'package:carpool/presentation/screens/auth/admin%20login/cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminLoginCubit extends Cubit<AdminLoginStates> {
  AdminLoginCubit() : super(AdminLoginIntialState());

  static AdminLoginCubit get(context) => BlocProvider.of(context);

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? phoneNumberErrorMessage;
  bool phoneNumberValid = false;

  bool isPasswordVisible = true;

  void passwordChanged() {
    emit(AdminLoginPasswordChanged());
  }

  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(AdminLoginChangePasswordVisibilityState());
  }

  void isPhoneNumberValid(BuildContext context) {
    bool isPhoneNumberValid = PresentationConstances.isPhoneNumberValid(phoneNumberController.text);
    if (isPhoneNumberValid) {
      phoneNumberErrorMessage = null;
      phoneNumberValid = true;
    } else {
      phoneNumberErrorMessage = AppStrings.phoneNumberNotValid.tr(context);
    }
    emit(AdminLoginIsPhoneNumberValidState());
  }

  final AdminLoginUsecase _adminLoginUsecase = AdminLoginUsecase(getIt());
  final AppPrefences _appPrefences = AppPrefences(getIt());
  Future<void> login(BuildContext context, bool isClient) async {
    emit(AdminLoginLoadingState());
    (await _adminLoginUsecase.execute(phoneNumberController.text, passwordController.text)).fold(
      (failure) {
        errorToast(failure.message).show(context);
        emit(AdminLoginErrorState());
      },
      (driver) {
        _appPrefences.setId(driver.id);
        _appPrefences.setToken(driver.token!);
        _appPrefences.setRole('admin');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminMainView(),
            ),
            (route) => false);
        emit(AdminLoginSuccessState());
      },
    );
  }
}
