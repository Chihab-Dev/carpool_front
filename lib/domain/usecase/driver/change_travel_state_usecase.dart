import 'package:carpool/app/failure.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class DriverChangeTravelStateUsecase {
  final Repository _repository;

  DriverChangeTravelStateUsecase(this._repository);

  Future<Either<Failure, void>> execute(String state, String travelId) async {
    return await _repository.changeTravelState(state, travelId);
  }
}
