import 'dart:io';

import 'package:carpool/app/service_locator.dart';
import 'package:carpool/app/shared_prefrences.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/domain/usecase/client/register_usecase.dart';
import 'package:carpool/domain/usecase/client/upload_image.dart';
import 'package:carpool/domain/usecase/driver/driver_register.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/constants.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:carpool/presentation/screens/Client/main/view/main_view.dart';
import 'package:carpool/presentation/screens/auth/register/cubit/register_state.dart';
import 'package:carpool/presentation/screens/auth/under_review/under_review_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  File? image;

  pickImage() async {
    var selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (selectedImage != null) {
      image = File(selectedImage.path);
    }
    emit(RegisterPickImageState());
  }

  String wilaya = 'Adrar';

  pickWilaya(String? value) {
    if (value != null) {
      wilaya = value;
    }
    emit(RegisterPickWilayaState());
  }

  DateTime selectedDate = DateTime.now();

  pickDate(BuildContext context) async {
    final DateTime? datetime = await showDatePicker(
      context: context,
      firstDate: DateTime(1962),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: ColorManager.white,
                onPrimary: ColorManager.yellow,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(foregroundColor: ColorManager.yellow),
              ),
            ),
            child: child!);
      },
    );
    if (datetime != null) {
      selectedDate = datetime;
    }
    emit(RegisterPickDateState());
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController familyNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  String? nameErrorMessage;
  String? familyNameErrorMessage;
  String? phoneNumberErrorMessage;
  String? passwordErrorMessage;
  bool nameValid = false;
  bool familyNameValid = false;
  bool phoneNumberValid = false;
  bool passwordValid = false;

  bool isPasswordVisible = true;

  void isPasswordValid() {
    bool isPasswordValid = PresentationConstances.isPasswordValid(passwordController.text);
    if (isPasswordValid) {
      passwordErrorMessage = null;
      passwordValid = true;
    } else {
      if (passwordController.text.length < 7) {
        passwordErrorMessage = 'too short';
        emit(RegisterIsPasswordValidState());
        return;
      }
      if (passwordController.text.length > 20) {
        passwordErrorMessage = 'too long';
        emit(RegisterIsPasswordValidState());
        return;
      }
      if (passwordController.text.startsWith(' ')) {
        passwordErrorMessage = 'start with space';
        emit(RegisterIsPasswordValidState());
        return;
      }
      if (passwordController.text.endsWith(' ')) {
        passwordErrorMessage = 'end with spac';
        emit(RegisterIsPasswordValidState());
        return;
      }
      if (passwordController.text.contains('  ')) {
        passwordErrorMessage = 'contains spaces';
      } else {
        passwordErrorMessage = 'password not valid';
      }
    }
    emit(RegisterIsPasswordValidState());
  }

  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(RegisterChangePasswordVisibilityState());
  }

  void isNameValid() {
    bool isNameValid = PresentationConstances.isNameValid(nameController.text);
    if (isNameValid == true) {
      nameValid = true;
      nameErrorMessage = null;
    } else {
      nameErrorMessage = AppStrings.nameNotValid;
    }
    emit(RegisterIsNameValidState());
  }

  void isFamilyNameValid() {
    bool isNameValid = PresentationConstances.isNameValid(familyNameController.text);
    if (isNameValid == true) {
      familyNameValid = true;
      familyNameErrorMessage = null;
    } else {
      familyNameErrorMessage = AppStrings.familyNameNotValid;
    }
    emit(RegisterIsFamilyNameValidState());
  }

  void isPhoneNumberValid() {
    bool isPhoneNumberValid = PresentationConstances.isPhoneNumberValid(phoneNumberController.text);
    if (isPhoneNumberValid) {
      phoneNumberErrorMessage = null;
      phoneNumberValid = true;
    } else {
      phoneNumberErrorMessage = AppStrings.phoneNumberNotValid;
    }
    emit(RegisterIsPhoneNumberValidState());
  }

  bool isEverythingValid() {
    if (nameValid && familyNameValid && wilaya != '' && passwordValid && phoneNumberValid && image != null) {
      return true;
    }
    return false;
  }

  final ClientRegisterUsecase _clientRegisterUsecase = ClientRegisterUsecase(getIt());
  final DriverRegisterUsecase _driverRegisterUsecase = DriverRegisterUsecase(getIt());

  final UploadImageUsecase _uploadImageUsecase = UploadImageUsecase(getIt());

  final AppPrefences _appPrefences = AppPrefences(getIt());
  Future<void> register(BuildContext context, bool isClient) async {
    if (isClient) {
      emit(RegisterLoadingState());
      (await _uploadImageUsecase.execute(image!)).fold(
        (failure) {
          errorToast(failure.message).show(context);
        },
        (imageUrl) async {
          (await _clientRegisterUsecase.execute(
            ClientModel(
              id: '',
              name: nameController.text,
              familyname: familyNameController.text,
              address: wilaya,
              dateofbirth: selectedDate.toString().substring(0, 10),
              password: passwordController.text,
              phoneNumber: phoneNumberController.text,
              image: imageUrl,
              feedbackes: [],
              token: '',
              email: '$wilaya${phoneNumberController.text}@gmail.com',
            ),
          ))
              .fold(
            (failure) {
              errorToast(failure.message).show(context);
              emit(RegisterErrorState());
            },
            (data) {
              _appPrefences.setId(data.id);
              _appPrefences.setToken(data.token!);
              _appPrefences.setRole('client');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainView(),
                ),
                (route) => false,
              );
              emit(RegisterSuccessState());
            },
          );
        },
      );
    } else {
      emit(RegisterLoadingState());
      (await _uploadImageUsecase.execute(image!)).fold(
        (failure) {
          errorToast(failure.message).show(context);
        },
        (imageUrl) async {
          (await _driverRegisterUsecase.execute(
            DriverModel(
              id: '',
              name: nameController.text,
              familyname: familyNameController.text,
              address: wilaya,
              birthday: selectedDate.toString().substring(0, 10),
              password: passwordController.text,
              phoneNumber: phoneNumberController.text,
              image: imageUrl,
              feedbackes: [],
              token: '',
              isAccepted: false,
              email: '$wilaya${phoneNumberController.text}@gmail.com',
            ),
          ))
              .fold(
            (failure) {
              errorToast(failure.message).show(context);
              emit(RegisterErrorState());
            },
            (data) {
              // _appPrefences.setId(data.id);
              // _appPrefences.setToken(data.token!);
              // _appPrefences.setRole('driver');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const UnderReviewView(),
                ),
                (route) => false,
              );
              emit(RegisterSuccessState());
            },
          );
        },
      );
    }
  }
}
