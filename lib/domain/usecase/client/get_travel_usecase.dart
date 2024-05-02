import 'package:carpool/app/failure.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class ClientGetTravelUsecase {
  final Repository _repository;

  ClientGetTravelUsecase(this._repository);

  Future<Either<Failure, List<TravelModel>>> execute(String placeOfDeparture, String placeOfArrival) async {
    return await _repository.getTravel(placeOfDeparture, placeOfArrival);
  }
}
