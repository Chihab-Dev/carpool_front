import 'package:carpool/app/failure.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class UpdateTravelUsecase {
  final Repository _repository;

  UpdateTravelUsecase(this._repository);

  Future<Either<Failure, void>> execute(TravelModel travel) async {
    return await _repository.updateTravel(travel);
  }
}
