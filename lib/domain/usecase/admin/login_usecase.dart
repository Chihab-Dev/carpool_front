import 'package:carpool/app/failure.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class AdminLoginUsecase {
  final Repository _repository;

  AdminLoginUsecase(this._repository);

  Future<Either<Failure, AdminModel>> execute(String phoneNumber, String password) async {
    return await _repository.adminLogin(phoneNumber, password);
  }
}
