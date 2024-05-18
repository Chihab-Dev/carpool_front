import 'package:carpool/app/failure.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class ClientGetTravelByIdUsecase {
  final Repository _repository;

  ClientGetTravelByIdUsecase(this._repository);

  Future<Either<Failure, TravelModel>> execute(String id) async {
    return await _repository.clientGetTravelById(id);
  }
}
