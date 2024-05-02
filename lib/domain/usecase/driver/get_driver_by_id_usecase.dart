import 'package:carpool/app/failure.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class DriverGetDriverByIdUsecase {
  final Repository _repository;

  DriverGetDriverByIdUsecase(this._repository);

  Future<Either<Failure, DriverModel>> execute(String id) async {
    return await _repository.getDriverById(id);
  }
}
