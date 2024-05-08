import 'package:carpool/app/failure.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class DriverSendFeedbackUsecase {
  final Repository _repository;

  DriverSendFeedbackUsecase(this._repository);

  Future<Either<Failure, void>> execute(FeedbackModel feedback) async {
    return await _repository.driverSendFeedback(feedback);
  }
}
