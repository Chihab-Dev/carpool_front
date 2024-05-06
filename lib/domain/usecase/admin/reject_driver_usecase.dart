import 'package:carpool/app/failure.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class AdminRejectDriverUsecase {
  final Repository _repository;

  AdminRejectDriverUsecase(this._repository);

  Future<Either<Failure, void>> execute(String id) async {
    return await _repository.rejectDriver(id);
  }
}
