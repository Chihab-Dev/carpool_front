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

  //----------------------------------------------------- DRIVER -----------------------------------------------------
  Future<Either<Failure, DriverModel>> driverLogin(String phoneNumber, String password);
  Future<Either<Failure, DriverModel>> driverRegister(DriverModel driver);
  Future<Either<Failure, DriverModel>> getDriverById(String id);
  Future<Either<Failure, void>> createTravel(TravelModel travelModel);
}
