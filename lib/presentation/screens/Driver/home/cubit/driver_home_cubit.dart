import 'dart:io';

import 'package:carpool/app/service_locator.dart';
import 'package:carpool/app/shared_prefrences.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/domain/usecase/driver/create_travel_usecase.dart';
import 'package:carpool/domain/usecase/driver/get_driver_by_id_usecase.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
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

  DriverCreateTravelUsecase driverCreateTravelUsecase = DriverCreateTravelUsecase(getIt());

  Future<void> createTravel(BuildContext context) async {
    emit(DriverCreateTravelLoadingState());
    (await driverCreateTravelUsecase.execute(
      TravelModel(
        travelId: '',
        placeOfDeparture: pickedFromLocation!.address.toString(),
        timeOfDeparture: "${pickedFromTime!.hour}:${pickedFromTime!.minute}",
        placeOfArrival: pickedToLocation!.address.toString(),
        timeOfArrival: "${pickedtoTime!.hour}:${pickedtoTime!.minute}",
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
        emit(DriverCreateTravelErrorState());
      },
      (data) {
        emit(DriverCreateTravelSuccessState());
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
    emit(DriverCheckValidationState());
    return isEverythingValid;
  }

  final DriverGetDriverByIdUsecase _driverByIdUsecase = DriverGetDriverByIdUsecase(getIt());

  DriverModel? driverModel;

  Future<void> getDriverById(BuildContext context) async {
    emit(DriverGetDriverLoadingState());
    final AppPrefences appPrefences = AppPrefences(getIt());
    var id = appPrefences.getId();

    (await _driverByIdUsecase.execute(id)).fold(
      (failure) {
        errorToast(failure.message).show(context);
        emit(DriverGetDriverErrorState());
      },
      (data) {
        driverModel = data;
        emit(DriverGetDriverSuccessState());
      },
    );
  }
}
