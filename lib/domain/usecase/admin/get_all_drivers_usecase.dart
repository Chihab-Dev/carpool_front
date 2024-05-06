import 'package:carpool/app/failure.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class AdminGetAllDriversUsecase {
  final Repository _repository;

  AdminGetAllDriversUsecase(this._repository);

  Future<Either<Failure, List<DriverModel>>> execute() async {
    return await _repository.getAllDrivers();
  }
}
