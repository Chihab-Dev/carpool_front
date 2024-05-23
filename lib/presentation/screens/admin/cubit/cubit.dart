import 'package:carpool/app/service_locator.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/domain/usecase/admin/accept_driver_usecase.dart';
import 'package:carpool/domain/usecase/admin/delete_client_usecase.dart';
import 'package:carpool/domain/usecase/admin/delete_driver_usecase.dart';
import 'package:carpool/domain/usecase/admin/delete_travel_usecase.dart';
import 'package:carpool/domain/usecase/admin/get_all_clients_usecase.dart';
import 'package:carpool/domain/usecase/admin/get_all_drivers_usecase.dart';
import 'package:carpool/domain/usecase/admin/get_all_travels_usecase.dart';
import 'package:carpool/domain/usecase/admin/reject_driver_usecase.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:carpool/presentation/screens/admin/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(AdminInitialState());

  static AdminCubit get(context) => BlocProvider.of(context);

  final AdminGetAllDriversUsecase _adminGetAllDriversUsecase = AdminGetAllDriversUsecase(getIt());
  final AdminGetAllClientsUsecase _adminGetAllClientsUsecase = AdminGetAllClientsUsecase(getIt());
  final AdminGetAllTravelsUsecase _adminGetAllTravelsUsecase = AdminGetAllTravelsUsecase(getIt());
  final AdminAcceptDriverUsecase _adminAcceptDriverUsecase = AdminAcceptDriverUsecase(getIt());
  final AdminRejectDriverUsecase _adminRejectDriverUsecase = AdminRejectDriverUsecase(getIt());
  final AdminDeleteDriverUsecase _adminDeleteDriverUsecase = AdminDeleteDriverUsecase(getIt());
  final AdminDeleteClientUsecase _adminDeleteClientUsecase = AdminDeleteClientUsecase(getIt());
  final AdminDeleteTravelUsecase _adminDeleteTravelUsecase = AdminDeleteTravelUsecase(getIt());

  List<DriverModel> acceptedDrivers = [];
  List<DriverModel> notAcceptedDrivers = [];
  List<ClientModel> clients = [];
  List<TravelModel> travels = [];

  Future<void> getAllDrivers(BuildContext context) async {
    emit(AdminGetAllDriversLoadingState());
    (await _adminGetAllDriversUsecase.execute()).fold(
      (failure) {
        errorToast(failure.message).show(context);
        emit(AdminGetAllDriversErrorState());
      },
      (data) {
        acceptedDrivers = [];
        notAcceptedDrivers = [];
        for (var driver in data) {
          if (driver.isAccepted == true) {
            acceptedDrivers.add(driver);
          } else {
            notAcceptedDrivers.add(driver);
          }
        }
        emit(AdminGetAllDriversSuccessState());
      },
    );
  }

  Future<void> getAllClients(BuildContext context) async {
    emit(AdminGetAllClientsLoadingState());
    (await _adminGetAllClientsUsecase.execute()).fold(
      (failure) {
        errorToast(failure.message).show(context);
        emit(AdminGetAllClientsErrorState());
      },
      (data) {
        clients = data;
        emit(AdminGetAllClientsSuccessState());
      },
    );
  }

  Future<void> getAllTravels(BuildContext context) async {
    emit(AdminGetAllTravelsLoadingState());
    (await _adminGetAllTravelsUsecase.execute()).fold(
      (failure) {
        errorToast(failure.message).show(context);
        emit(AdminGetAllTravelsErrorState());
      },
      (data) {
        travels = data;
        emit(AdminGetAllTravelsSuccessState());
      },
    );
  }

  Future<void> acceptDriver(BuildContext context, String id) async {
    emit(AdminAcceptDriverLoadingState());
    (await _adminAcceptDriverUsecase.execute(id)).fold(
      (failure) {
        errorToast(failure.message).show(context);
        emit(AdminAcceptDriverErrorState());
      },
      (data) {
        emit(AdminAcceptDriverSuccessState());
      },
    );
  }

  Future<void> rejectDriver(BuildContext context, String id) async {
    emit(AdminRejectDriverLoadingState());
    (await _adminRejectDriverUsecase.execute(id)).fold(
      (failure) {
        errorToast(failure.message).show(context);
        emit(AdminRejectDriverErrorState());
      },
      (data) {
        emit(AdminRejectDriverSuccessState());
      },
    );
  }

  Future<void> deleteDriver(BuildContext context, String id) async {
    emit(AdminDeleteDriverLoadingState());
    (await _adminDeleteDriverUsecase.execute(id)).fold(
      (failure) {
        errorToast(failure.message).show(context);
        emit(AdminDeleteDriverErrorState());
      },
      (data) {
        Navigator.pop(context);
        emit(AdminDeleteDriverSuccessState());
      },
    );
  }

  Future<void> deleteClient(BuildContext context, String id) async {
    emit(AdminDeleteClientLoadingState());
    (await _adminDeleteClientUsecase.execute(id)).fold(
      (failure) {
        errorToast(failure.message).show(context);
        emit(AdminDeleteClientErrorState());
      },
      (data) {
        Navigator.pop(context);
        emit(AdminDeleteClientSuccessState());
      },
    );
  }

  Future<void> deleteTravel(BuildContext context, String id) async {
    emit(AdminDeleteTravelLoadingState());
    (await _adminDeleteTravelUsecase.execute(id)).fold(
      (failure) {
        errorToast(failure.message).show(context);
        emit(AdminDeleteTravelErrorState());
      },
      (data) {
        Navigator.pop(context);
        emit(AdminDeleteTravelSuccessState());
      },
    );
  }

  int acceptedRequests = 0;
  void calculateAcceptedRequests(List<RequestModel>? requests) {
    acceptedRequests = 0;
    if (requests != null && requests.isNotEmpty) {
      for (var request in requests) {
        if (request.state == 'accept') {
          acceptedRequests++;
        }
      }
    }
    emit(AdminCalculateAcceptedRequestsState());
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
