import 'package:carpool/app/service_locator.dart';
import 'package:carpool/app/shared_prefrences.dart';
import 'package:carpool/domain/usecase/client/login_usecase.dart';
import 'package:carpool/domain/usecase/driver/driver_login.dart';
import 'package:carpool/presentation/components/constants.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:carpool/presentation/screens/Client/main/view/main_view.dart';
import 'package:carpool/presentation/screens/Driver/main/view/driver_main_view.dart';
import 'package:carpool/presentation/screens/auth/login/cubit/login_states.dart';
import 'package:carpool/presentation/screens/auth/under_review/under_review_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginIntialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? phoneNumberErrorMessage;
  bool phoneNumberValid = false;

  bool isPasswordVisible = true;

  void passwordChanged() {
    emit(LoginPasswordChanged());
  }

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
    emit(LoginIsPhoneNumberValidState());
  }

  final ClientLoginUsecase _clientLoginUsecase = ClientLoginUsecase(getIt());
  final DriverLoginUsecase _driverLoginUsecase = DriverLoginUsecase(getIt());

  final AppPrefences _appPrefences = AppPrefences(getIt());
  Future<void> login(BuildContext context, bool isClient) async {
    if (isClient) {
      emit(LoginLoadingState());
      (await _clientLoginUsecase.execute(phoneNumberController.text, passwordController.text)).fold(
        (failure) {
          errorToast(failure.message).show(context);
          emit(LoginErrorState());
        },
        (data) {
          _appPrefences.setId(data.id);
          _appPrefences.setToken(data.token!);
          _appPrefences.setIsClient(isClient);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MainView(),
            ),
            (route) => false,
          );
          emit(LoginSuccessState());
        },
      );
    } else {
      emit(LoginLoadingState());
      (await _driverLoginUsecase.execute(phoneNumberController.text, passwordController.text)).fold(
        (failure) {
          errorToast(failure.message).show(context);
          emit(LoginErrorState());
        },
        (driver) {
          _appPrefences.setId(driver.id);
          _appPrefences.setToken(driver.token!);
          _appPrefences.setIsClient(isClient);
          if (driver.isAccepted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const DriverMainView(),
              ),
              (route) => false,
            );
          } else {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const UnderReviewView(),
              ),
              (route) => false,
            );
          }

          emit(LoginSuccessState());
        },
      );
    }
  }
}
