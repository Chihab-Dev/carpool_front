import 'dart:io';

import 'package:carpool/presentation/screens/auth/register/cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  File? image;

  pickImage() async {
    var selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      image = File(selectedImage.path);
    }
    emit(RegisterPickImageState());
  }

  String wilaya = 'oran';

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
      firstDate: selectedDate,
      lastDate: DateTime(2026),
    );
    if (datetime != null) {
      selectedDate = datetime;
    }
    emit(RegisterPickDateState());
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController familyNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
}