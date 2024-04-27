import 'package:carpool/app/failure.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class ClientLoginUsecase {
  final Repository _repository;

  ClientLoginUsecase(this._repository);

  Future<Either<Failure, ClientModel>> execute(String phoneNumber, String password) async {
    return await _repository.clientLogin(phoneNumber, password);
  }
}
