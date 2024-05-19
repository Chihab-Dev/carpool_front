import 'package:carpool/app/failure.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class UpdateRequestStateUsecase {
  final Repository _repository;

  UpdateRequestStateUsecase(this._repository);

  Future<Either<Failure, void>> execute(String state, String requestId, String travelId) async {
    return await _repository.updateRequestState(state, requestId, travelId);
  }
}
