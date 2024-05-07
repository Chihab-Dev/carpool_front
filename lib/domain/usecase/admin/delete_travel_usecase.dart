import 'package:carpool/app/failure.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class AdminDeleteTravelUsecase {
  final Repository _repository;

  AdminDeleteTravelUsecase(this._repository);

  Future<Either<Failure, void>> execute(String id) async {
    return await _repository.deleteTravel(id);
  }
}
