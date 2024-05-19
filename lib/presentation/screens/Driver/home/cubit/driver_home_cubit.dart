import 'dart:io';

import 'package:carpool/app/service_locator.dart';
import 'package:carpool/app/shared_prefrences.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/domain/usecase/driver/create_travel_usecase.dart';
import 'package:carpool/domain/usecase/driver/get_driver_by_id_usecase.dart';
import 'package:carpool/domain/usecase/driver/get_travel_by_id_usecase.dart';
import 'package:carpool/domain/usecase/driver/send_feedback_usecase.dart';
import 'package:carpool/domain/usecase/driver/update_request_state_usecase.dart';
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
    checkValidation();

    emit(DriverHomeChooseLocation());
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
    emit(DriverHomePickTime());
  }

  String _formatTime(TimeOfDay time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
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
    checkValidation();

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
    checkValidation();
    emit(DriverHomePickImage());
  }

  DriverCreateTravelUsecase driverCreateTravelUsecase = DriverCreateTravelUsecase(getIt());

  Future<void> createTravel(BuildContext context) async {
    emit(DriverCreateTravelLoadingState());
    (await driverCreateTravelUsecase.execute(
      TravelModel(
        travelId: '',
        placeOfDeparture: pickedFromLocation!.address.toString(),
        timeOfDeparture: "$pickedFromTime",
        placeOfArrival: pickedToLocation!.address.toString(),
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
        emit(DriverCreateTravelErrorState());
      },
      (data) {
        successToast('✅ CREATED TRAVEL SUCCESS ✅').show(context);
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

  int rating = 0;
  void changeRating(int rate) {
    rating = rate;
    emit(DriverChangeRatingState());
  }

  TextEditingController feedbackCommentController = TextEditingController();
  final DriverSendFeedbackUsecase _driverSendFeedbackUsecase = DriverSendFeedbackUsecase(getIt());

  bool feedbackValid = false;

  void changeFeedbackValidation() {
    if (rating != 0 && feedbackCommentController.text.isNotEmpty) {
      feedbackValid = true;
      emit(DriverChangeValidationState());
    }
  }

  Future<void> sendFeedback(BuildContext context, String clientId) async {
    emit(DriverSendFeedbackLoadingState());
    (await _driverSendFeedbackUsecase.execute(
      FeedbackModel(
        toUser: clientId,
        note: rating,
        comment: feedbackCommentController.text,
      ),
    ))
        .fold(
      (failure) {
        errorToast(failure.message).show(context);
        emit(DriverSendFeedbackErrorState());
      },
      (data) {
        feedbackCommentController.clear();
        rating = 0;
        feedbackValid = false;
        emit(DriverSendFeedbackSuccessState());
      },
    );
  }

  final DriverGetTravelByIdUsecase _driverGetTravelByIdUsecase = DriverGetTravelByIdUsecase(getIt());

  List<TravelModel> allMyTravels = [];

  Future<void> getMyTravels(BuildContext context) async {
    emit(DriverGetTravelByIdLoadingState());
    (await _driverGetTravelByIdUsecase.execute()).fold(
      (failure) {
        errorToast(failure.message).show(context);
        emit(DriverGetTravelByIdErrorState());
      },
      (data) {
        allMyTravels = data;
        successToast('Success get travel').show(context);
        emit(DriverGetTravelByIdSuccessState());
      },
    );
  }

  int acceptedRequests = 0;
  List<RequestModel> acceptRequestsList = [];
  List<RequestModel> pendingRequestsList = [];
  List<RequestModel> rejectRequestsList = [];

  void calculateAcceptedRequests(List<RequestModel>? requests) {
    acceptedRequests = 0;
    acceptRequestsList = [];
    pendingRequestsList = [];
    rejectRequestsList = [];
    if (requests != null && requests.isNotEmpty) {
      for (var request in requests) {
        print(request.state);
        if (request.state == 'accept') {
          acceptedRequests++;
          acceptRequestsList.add(request);
        } else if (request.state == 'reject') {
          rejectRequestsList.add(request);
        } else {
          pendingRequestsList.add(request);
        }
      }
    }
    emit(DriverCalculateAcceptedRequestsState());
  }

  final UpdateRequestStateUsecase _updateRequestStateUsecase = UpdateRequestStateUsecase(getIt());

  Future<void> updateRequestState(BuildContext context, String state, String requestId, TravelModel travelModel) async {
    emit(DriverUpdateRequestStateLoadingState());
    if (travelModel.numberOfPlaces == acceptedRequests && state == 'accept') {
      errorToast('travel is full').show(context);
    } else {
      (await _updateRequestStateUsecase.execute(state, requestId, travelModel.travelId)).fold(
        (failure) {
          errorToast(failure.message).show(context);
          emit(DriverUpdateRequestStateErrorState());
        },
        (data) {
          successToast("Request updated").show(context);
          emit(DriverUpdateRequestStateSuccessState());
        },
      );
    }
  }

  double calculateRate(List<FeedbackModel> feedbacks) {
    if (feedbacks.isNotEmpty) {
      double somme = 0;
      for (var feedback in feedbacks) {
        somme += feedback.note;
      }
      return somme / feedbacks.length;
    } else {
      return 0.0;
    }
  }
}
