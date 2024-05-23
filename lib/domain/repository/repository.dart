import 'package:carpool/app/failure.dart';
import 'package:carpool/data/models/models.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  //----------------------------------------------------- CLIENT -----------------------------------------------------
  Future<Either<Failure, ClientModel>> clientLogin(String phoneNumber, String password);
  Future<Either<Failure, ClientModel>> clientRegister(ClientModel client);
  Future<Either<Failure, List<TravelModel>>> getTravel(String placeOfDeparture, String placeOfArrival);
  Future<Either<Failure, ClientModel>> getClientById(String id);
  Future<Either<Failure, void>> requestToBook(String travelId);
  Future<Either<Failure, void>> clientSendFeedback(FeedbackModel feedback);
  Future<Either<Failure, TravelModel>> clientGetTravelById(String id);
  Future<Either<Failure, List<TravelModel>>> clientGetAllTravels();
  Future<Either<Failure, void>> deleteClientRequest(String id);
  Future<Either<Failure, void>> changeTravelState(String state, String travelId);

  //----------------------------------------------------- DRIVER -----------------------------------------------------
  Future<Either<Failure, DriverModel>> driverLogin(String phoneNumber, String password);
  Future<Either<Failure, DriverModel>> driverRegister(DriverModel driver);
  Future<Either<Failure, DriverModel>> getDriverById(String id);
  Future<Either<Failure, void>> createTravel(TravelModel travelModel);
  Future<Either<Failure, void>> driverSendFeedback(FeedbackModel feedback);
  Future<Either<Failure, void>> updateTravel(TravelModel travel);
  Future<Either<Failure, List<TravelModel>>> driverGetTravelById();
  Future<Either<Failure, void>> updateRequestState(String state, String requestId, String travelId);
  Future<Either<Failure, void>> driverDeleteTravel(String id);

  //----------------------------------------------------- ADMIN -----------------------------------------------------
  Future<Either<Failure, AdminModel>> adminLogin(String phoneNumber, String password);
  Future<Either<Failure, List<DriverModel>>> getAllDrivers();
  Future<Either<Failure, List<ClientModel>>> getAllClients();
  Future<Either<Failure, List<TravelModel>>> getAllTravels();
  Future<Either<Failure, void>> acceptDriver(String id);
  Future<Either<Failure, void>> rejectDriver(String id);
  Future<Either<Failure, void>> deleteDriver(String id);

  Future<Either<Failure, void>> deleteClient(String id);
  Future<Either<Failure, void>> deleteTravel(String id);
}
