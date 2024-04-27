import 'package:carpool/app/failure.dart';
import 'package:carpool/data/models/models.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  //----------------------------------------------------- CLIENT -----------------------------------------------------
  Future<Either<Failure, ClientModel>> clientLogin(String phoneNumber, String password);
  Future<Either<Failure, ClientModel>> clientRegister(ClientModel client);

  //----------------------------------------------------- DRIVER -----------------------------------------------------
  Future<Either<Failure, DriverModel>> driverLogin(String phoneNumber, String password);
  Future<Either<Failure, DriverModel>> driverRegister(DriverModel driver);
}
