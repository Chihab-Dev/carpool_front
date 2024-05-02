import 'package:carpool/app/failure.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class ClientRequestToBookUsecase {
  final Repository _repository;

  ClientRequestToBookUsecase(this._repository);

  Future<Either<Failure, void>> execute(String travelId) async {
    return await _repository.requestToBook(travelId);
  }
}
