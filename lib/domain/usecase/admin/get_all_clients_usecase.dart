import 'package:carpool/app/failure.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class AdminGetAllClientsUsecase {
  final Repository _repository;

  AdminGetAllClientsUsecase(this._repository);

  Future<Either<Failure, List<ClientModel>>> execute() async {
    return await _repository.getAllClients();
  }
}
