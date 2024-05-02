import 'package:carpool/app/failure.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class ClientGetClientByIdUsecase {
  final Repository _repository;

  ClientGetClientByIdUsecase(this._repository);

  Future<Either<Failure, ClientModel>> execute(String id) async {
    return await _repository.getClientById(id);
  }
}
