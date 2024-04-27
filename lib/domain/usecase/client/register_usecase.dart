import 'package:carpool/app/failure.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class ClientRegisterUsecase {
  final Repository _repository;

  ClientRegisterUsecase(this._repository);

  Future<Either<Failure, ClientModel>> execute(ClientModel client) async {
    return await _repository.clientRegister(client);
  }
}
