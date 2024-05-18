import 'package:carpool/app/failure.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class DriverGetTravelByIdUsecase {
  final Repository _repository;

  DriverGetTravelByIdUsecase(this._repository);

  Future<Either<Failure, TravelModel>> execute(String id) async {
    return await _repository.driverGetTravelById(id);
  }
}
