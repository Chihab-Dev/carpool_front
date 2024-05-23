import 'package:carpool/app/failure.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class DriverDeleteTravelUsecase {
  final Repository _repository;

  DriverDeleteTravelUsecase(this._repository);

  Future<Either<Failure, void>> execute(String id) async {
    return await _repository.driverDeleteTravel(id);
  }
}
