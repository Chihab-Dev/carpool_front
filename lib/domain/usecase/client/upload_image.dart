import 'dart:io';

import 'package:carpool/app/failure.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class UploadImageUsecase {
  final Repository _repository;

  UploadImageUsecase(this._repository);

  Future<Either<Failure, String>> execute(File imageFile) async {
    return await _repository.uploadImageAndGetUrl(imageFile);
  }
}
