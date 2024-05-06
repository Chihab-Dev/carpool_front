import 'package:carpool/app/failure.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class AdminAcceptDriverUsecase {
  final Repository _repository;

  AdminAcceptDriverUsecase(this._repository);

  Future<Either<Failure, void>> execute(String id) async {
    return await _repository.acceptDriver(id);
  }
}
