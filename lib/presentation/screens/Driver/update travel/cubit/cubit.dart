import 'dart:io';

import 'package:carpool/app/service_locator.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/domain/usecase/driver/update_travel_usecase.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:carpool/presentation/screens/Driver/update%20travel/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:image_picker/image_picker.dart';

class UpdateTravelCubit extends Cubit<UpdateTravelState> {
  UpdateTravelCubit() : super(UpdateTravelInitialState());

  static UpdateTravelCubit get(context) => BlocProvider.of(context);

  void start(TravelModel travel) {
    pickedFromLocation = travel.placeOfDeparture;
    pickedToLocation = travel.placeOfArrival;

    pickedFromTime = travel.timeOfDeparture;
    pickedtoTime = travel.timeOfArrival;
    numberOfSeats = travel.numberOfPlaces;
    placePrice = travel.placePrice;
    baggageSizeAllowed = travel.baggage;
    numOfBaggageSizeAllowed = travel.baggage == 'S'
        ? 1
        : travel.baggage == "M"
            ? 2
            : travel.baggage == 'L'
                ? 3
                : 2;
    petsAllowed = travel.allowPets;
    numOfPetsAllowed = travel.allowPets == false ? 1 : 2;
    smokingAllowed = travel.allowSmoking;
    numOfsmokingAllowed = travel.allowSmoking == false ? 1 : 2;
    selectedDate = travel.dateOfDeparture;
    carNameController.text = travel.carName;
    isEverythingValid = true;
  }

  TextEditingController locationController = TextEditingController();
  List<SearchInfo> listSource = [];
  String? pickedFromLocation;
  String? pickedToLocation;
  bool? isItFrom;

  Future<void> searchForLocation() async {
    var data = await addressSuggestion(locationController.text, limitInformation: 5);

    if (data.isNotEmpty) {
      listSource = data;
    }
    emit(UpdateTravelSearchForLocation());
  }

  void chooseLocation(int index, BuildContext context) {
    if (isItFrom!) {
      pickedFromLocation = listSource[index].address.toString();
    } else {
      pickedToLocation = listSource[index].address.toString();
    }
    locationController.clear();
    print(listSource[index].address);
    listSource = [];
    checkValidation();
    emit(UpdateTravelChooseLocation());
    Navigator.pop(context);
  }

  String? pickedFromTime;
  String? pickedtoTime;

  Future<void> pickTime(BuildContext context) async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (isItFrom == true && time != null) {
      pickedFromTime = _formatTime(time);
    } else if (isItFrom == false && time != null) {
      pickedtoTime = _formatTime(time);
    }
    checkValidation();

    emit(UpdateTravelPickTime());
  }

  String _formatTime(TimeOfDay time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  int numberOfSeats = 1;

  void pickNumberOfPlaces(int? value) {
    numberOfSeats = value ?? 1;
    checkValidation();

    emit(UpdateTravelPickNumberOfSeats());
  }

  int placePrice = 500;

  void pickPrice(int? value) {
    placePrice = value ?? 1;
    checkValidation();

    emit(UpdateTravelPickPersonPrice());
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
    checkValidation();
    emit(UpdateTravelPickBaggageSize());
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
    checkValidation();
    emit(UpdateTravelPickPetsAllowed());
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
    checkValidation();
    emit(UpdateTravelPickSmokingAllowed());
  }

  String selectedDate = DateTime.now().toString();

  pickDate(BuildContext context) async {
    final DateTime? datetime = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
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
      selectedDate = datetime.toString();
    }
    checkValidation();

    emit(UpdateTravelPickDate());
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
    checkValidation();

    emit(UpdateTravelPickImage());
  }

  final UpdateTravelUsecase _updateTravelUsecase = UpdateTravelUsecase(getIt());
  Future<void> updateTravel(BuildContext context, TravelModel travel) async {
    emit(UpdateTravelLoadingState());
    (await _updateTravelUsecase.execute(
      TravelModel(
        travelId: '663a0229733f21f5503fd157',
        placeOfDeparture: pickedFromLocation!,
        timeOfDeparture: "$pickedFromTime",
        placeOfArrival: pickedToLocation!,
        timeOfArrival: "$pickedtoTime",
        numberOfPlaces: numberOfSeats,
        carName: carNameController.text,
        carImage: image.toString(),
        placePrice: placePrice,
        allowSmoking: smokingAllowed,
        allowPets: petsAllowed,
        requests: [],
        driver: DriverModel(
          id: 'id',
          name: 'name',
          familyname: 'familyname',
          address: 'address',
          birthday: 'birthday',
          phoneNumber: 'adsfaf',
          image: 'image',
          password: 'password',
          feedbackes: [],
          isAccepted: true,
          token: 'token',
        ),
        baggage: baggageSizeAllowed,
        dateOfDeparture: selectedDate.toString(),
      ),
    ))
        .fold(
      (failure) {
        errorToast(failure.message).show(context);
        emit(UpdateTravelErrorState());
      },
      (data) {
        successToast('✅ CREATED TRAVEL SUCCESS ✅').show(context);
        emit(UpdateTravelSuccessState());
      },
    );
  }

  bool isEverythingValid = false;
  bool checkValidation() {
    if (pickedFromLocation != null &&
        pickedToLocation != null &&
        pickedFromTime != null &&
        pickedtoTime != null &&
        carNameController.text.isNotEmpty &&
        image != null) {
      isEverythingValid = true;
    } else {
      isEverythingValid = false;
    }
    print(pickedFromLocation.toString() +
        pickedToLocation.toString() +
        pickedFromTime.toString() +
        pickedtoTime.toString() +
        carNameController.text.isNotEmpty.toString() +
        image.toString());
    emit(UpdateTravelCheckValidationState());
    return isEverythingValid;
  }
}
