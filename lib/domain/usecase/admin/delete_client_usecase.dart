import 'package:carpool/app/failure.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class AdminDeleteClientUsecase {
  final Repository _repository;

  AdminDeleteClientUsecase(this._repository);

  Future<Either<Failure, void>> execute(String id) async {
    return await _repository.deleteClient(id);
  }
}
