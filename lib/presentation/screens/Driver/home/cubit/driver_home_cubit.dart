import 'dart:io';

import 'package:carpool/presentation/components/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:image_picker/image_picker.dart';

part 'driver_home_state.dart';

class DriverHomeCubit extends Cubit<DriverHomeState> {
  DriverHomeCubit() : super(DriverHomeInitial());

  static DriverHomeCubit get(context) => BlocProvider.of(context);

  TextEditingController locationController = TextEditingController();
  List<SearchInfo> listSource = [];
  SearchInfo? pickedFromLocation;
  SearchInfo? pickedToLocation;
  bool? isItFrom;

  Future<void> searchForLocation() async {
    var data = await addressSuggestion(locationController.text, limitInformation: 5);

    if (data.isNotEmpty) {
      listSource = data;
    }
    emit(DriverHomeSearchForLocation());
  }

  void chooseLocation(int index, BuildContext context) {
    if (isItFrom!) {
      pickedFromLocation = listSource[index];
    } else {
      pickedToLocation = listSource[index];
    }
    locationController.clear();
    print(listSource[index].address);
    listSource = [];
    emit(DriverHomeChooseLocation());
    Navigator.pop(context);
  }

  TimeOfDay? pickedFromTime;
  TimeOfDay? pickedtoTime;

  Future<void> pickTime(BuildContext context) async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (isItFrom == true && time != null) {
      pickedFromTime = time;
    } else {
      pickedtoTime = time;
    }
    emit(DriverHomePickTime());
  }

  int numberOfSeats = 1;

  void pickNumberOfPlaces(int? value) {
    numberOfSeats = value ?? 1;
    emit(DriverHomePickNumberOfSeats());
  }

  int placePrice = 500;

  void pickPrice(int? value) {
    placePrice = value ?? 1;
    emit(DriverHomePickPersonPrice());
  }

  String baggageSizeAllowed = 'M';
  int numOfBaggageSizeAllowed = 2;

  void changeBaggaeAllowed(int? value) {
    switch (value) {
      case 1:
        baggageSizeAllowed = "S";
        numOfBaggageSizeAllowed = 1;
        break;
      case 2:
        baggageSizeAllowed = "M";
        numOfBaggageSizeAllowed = 2;
        break;
      case 3:
        baggageSizeAllowed = "L";
        numOfBaggageSizeAllowed = 3;
        break;
      default:
        baggageSizeAllowed = "M";
        numOfBaggageSizeAllowed = 2;
        break;
    }
    emit(DriverHomePickBaggageSize());
  }

  bool petsAllowed = false;
  int numOfPetsAllowed = 1;

  void changePetsAllowed(int? value) {
    switch (value) {
      case 1:
        petsAllowed = false;
        numOfPetsAllowed = 1;
        break;
      case 2:
        petsAllowed = true;
        numOfPetsAllowed = 2;
        break;

      default:
        petsAllowed = false;
        numOfPetsAllowed = 1;
        break;
    }
    emit(DriverHomePickPetsAllowed());
  }

  bool smokingAllowed = false;
  int numOfsmokingAllowed = 1;

  void changesmokingAllowed(int? value) {
    switch (value) {
      case 1:
        smokingAllowed = false;
        numOfsmokingAllowed = 1;
        break;
      case 2:
        smokingAllowed = true;
        numOfsmokingAllowed = 2;
        break;

      default:
        smokingAllowed = false;
        numOfsmokingAllowed = 1;
        break;
    }
    emit(DriverHomePickSmokingAllowed());
  }

  DateTime selectedDate = DateTime.now();

  pickDate(BuildContext context) async {
    final DateTime? datetime = await showDatePicker(
      context: context,
      firstDate: selectedDate,
      lastDate: DateTime(2026),
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
    emit(DriverHomePickDate());
  }

  TextEditingController carNameController = TextEditingController();
  File? image;

  pickImage() async {
    final imagePicker = ImagePicker();
    var selectedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      print(selectedImage.path);
      image = File(selectedImage.path);
    }
    emit(DriverHomePickImage());
  }
}