import 'package:carpool/app/service_locator.dart';
import 'package:carpool/app/shared_prefrences.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/domain/usecase/client/get_client_by_id_usecase.dart';
import 'package:carpool/domain/usecase/client/get_travel_usecase.dart';
import 'package:carpool/domain/usecase/client/request_to_book_usecase.dart';
import 'package:carpool/domain/usecase/client/send_feedback_usecase.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  // double latitude = 35.4269;
  // double longitude = 7.1460;

  // Future<void> getCurrentLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   // if (!serviceEnabled) {
  //   //   // Location services are not enabled don't continue
  //   //   // accessing the position and request users of the
  //   //   // App to enable the location services.
  //   //   return Future.error('Location services are disabled.');
  //   // }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   var position = await Geolocator.getCurrentPosition(
  //     forceAndroidLocationManager: true,
  //     timeLimit: const Duration(seconds: 5),
  //     desiredAccuracy: LocationAccuracy.lowest,
  //   );
  //   latitude = position.latitude;
  //   longitude = position.longitude;
  //   print(position.latitude);
  //   print(position.longitude);
  // }

  TextEditingController locationController = TextEditingController();
  List<SearchInfo> listSource = [];
  SearchInfo? pickedFromLocation;
  SearchInfo? pickedToLocation;
  bool? isItFromLocation;

  Future<void> searchForLocation() async {
    var data = await addressSuggestion(locationController.text, limitInformation: 5);

    if (data.isNotEmpty) {
      listSource = data;
    }
    emit(HomeSearchForLocation());
  }

  void chooseLocation(int index, BuildContext context) {
    if (isItFromLocation!) {
      pickedFromLocation = listSource[index];
    } else {
      pickedToLocation = listSource[index];
    }
    locationController.clear();
    print(listSource[index].address);
    listSource = [];
    emit(HomeChooseLocation());
    Navigator.pop(context);
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
    emit(HomePickDateState());
  }

  int numberOfPlaces = 1;

  void pickNumberOfPlaces(int? value) {
    numberOfPlaces = value ?? 1;
    emit(HomePickNumberOfPlacesState());
  }

  final ClientGetTravelUsecase _clientGetTravelUsecase = ClientGetTravelUsecase(getIt());
  List<TravelModel> travels = [];

  Future<void> getTravel(BuildContext context) async {
    emit(HomeGetTravelLoadingState());
    (await _clientGetTravelUsecase.execute(
            pickedFromLocation!.address.toString(), pickedToLocation!.address.toString()))
        .fold(
      (failure) {
        errorToast(failure.message).show(context);
        emit(HomeGetTravelErrorState());
      },
      (data) {
        travels = data;
        emit(HomeGetTravelSuccessState());
      },
    );
  }

  final ClientGetClientByIdUsecase _clientByIdUsecase = ClientGetClientByIdUsecase(getIt());

  ClientModel? clientModel;

  Future<void> getClientById(BuildContext context) async {
    emit(HomeGetClientLoadingState());
    final AppPrefences appPrefences = AppPrefences(getIt());
    var id = appPrefences.getId();

    (await _clientByIdUsecase.execute(id)).fold(
      (failure) {
        errorToast(failure.message).show(context);
        emit(HomeGetClientErrorState());
      },
      (data) {
        clientModel = data;
        emit(HomeGetClientSuccessState());
      },
    );
  }

  ClientRequestToBookUsecase clientRequestToBookUsecase = ClientRequestToBookUsecase(getIt());

  void requestToBook(String travelId, BuildContext context) async {
    emit(HomeRequestToBookLoadingState());
    (await clientRequestToBookUsecase.execute(travelId)).fold(
      (failure) {
        errorToast(failure.message).show(context);
        emit(HomeRequestToBookErrorState());
      },
      (data) {
        emit(HomeRequestToBookSuccessState());
      },
    );
  }

  double rating = .0;
  void changeRating(double rate) {
    rating = rate;
    emit(HomeChangeRatingState());
  }

  TextEditingController feedbackCommentController = TextEditingController();
  final ClientSendFeedbackUsecase _clientSendFeedbackUsecase = ClientSendFeedbackUsecase(getIt());

  bool feedbackValid = false;

  void changeFeedbackValidation() {
    if (rating != .0 && feedbackCommentController.text.isNotEmpty) {
      feedbackValid = true;
      emit(HomeChangeValidationState());
    }
  }

  Future<void> sendFeedback(BuildContext context) async {
    emit(HomeSendFeedbackLoadingState());
    (await _clientSendFeedbackUsecase.execute(
            FeedbackModel(note: rating, comment: feedbackCommentController.text, userId: '662d0334d105bfaef2080831')))
        .fold(
      (failure) {
        errorToast(failure.message).show(context);
        emit(HomeSendFeedbackErrorState());
      },
      (data) {
        emit(HomeSendFeedbackSuccessState());
      },
    );
  }
}
