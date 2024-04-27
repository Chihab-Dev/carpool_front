import 'package:carpool/app/failure.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class DriverRegisterUsecase {
  final Repository _repository;

  DriverRegisterUsecase(this._repository);

  Future<Either<Failure, DriverModel>> execute(DriverModel driver) async {
    return await _repository.driverRegister(driver);
  }
}
