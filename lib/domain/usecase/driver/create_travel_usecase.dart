import 'package:carpool/app/failure.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class DriverCreateTravelUsecase {
  final Repository _repository;

  DriverCreateTravelUsecase(this._repository);

  Future<Either<Failure, void>> execute(TravelModel travelModel) async {
    return await _repository.createTravel(travelModel);
  }
}
