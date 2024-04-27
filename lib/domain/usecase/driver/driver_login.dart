import 'package:carpool/app/failure.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class DriverLoginUsecase {
  final Repository _repository;

  DriverLoginUsecase(this._repository);

  Future<Either<Failure, DriverModel>> execute(String phoneNumber, String password) async {
    return await _repository.driverLogin(phoneNumber, password);
  }
}
