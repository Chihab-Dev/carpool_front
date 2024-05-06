import 'package:carpool/app/failure.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class AdminGetAllTravelsUsecase {
  final Repository _repository;

  AdminGetAllTravelsUsecase(this._repository);

  Future<Either<Failure, List<TravelModel>>> execute() async {
    return await _repository.getAllTravels();
  }
}
