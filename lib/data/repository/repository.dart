import 'package:carpool/app/failure.dart';
import 'package:carpool/data/data_source/remote_data_source.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/data/network/network_info.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl extends Repository {
  NetworkInfo networkInfo;
  RemoteDataSource remoteDataSource;

  RepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  //----------------------------------------------------- CLIENT -----------------------------------------------------

  @override
  Future<Either<Failure, ClientModel>> clientLogin(String phoneNumber, String password) async {
    if (await networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.clientLogin(phoneNumber, password);
        return right(result);
      } catch (excpetion) {
        print(excpetion.toString());
        return left(Failure(excpetion.toString()));
      }
    } else {
      return left(Failure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, ClientModel>> clientRegister(ClientModel client) async {
    if (await networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.clientRegister(client);
        return right(result);
      } catch (e) {
        print(e.toString());
        return left(Failure(e.toString()));
      }
    } else {
      return left(Failure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<TravelModel>>> getTravel(String placeOfDeparture, String placeOfArrival) async {
    if (await networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.getTravel(placeOfDeparture, placeOfArrival);
        return right(result);
      } catch (e) {
        print(e.toString());
        return left(Failure(e.toString()));
      }
    } else {
      return left(Failure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, ClientModel>> getClientById(String id) async {
    if (await networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.getClientById(id);
        return right(result);
      } catch (e) {
        print(e.toString());
        return left(Failure(e.toString()));
      }
    } else {
      return left(Failure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> requestToBook(String travelId) async {
    if (await networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.requestToBook(travelId);
        return right(result);
      } catch (e) {
        print(e.toString());
        return left(Failure(e.toString()));
      }
    } else {
      return left(Failure('No internet connection'));
    }
  }
  //----------------------------------------------------- DRIVER -----------------------------------------------------

  @override
  Future<Either<Failure, DriverModel>> driverLogin(String phoneNumber, String password) async {
    if (await networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.driverLogin(phoneNumber, password);
        return right(result);
      } catch (excpetion) {
        print(excpetion.toString());
        return left(Failure(excpetion.toString()));
      }
    } else {
      return left(Failure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, DriverModel>> driverRegister(DriverModel driver) async {
    if (await networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.driverRegister(driver);
        return right(result);
      } catch (e) {
        print(e.toString());
        return left(Failure(e.toString()));
      }
    } else {
      return left(Failure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, DriverModel>> getDriverById(String id) async {
    if (await networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.getDriverById(id);
        return right(result);
      } catch (e) {
        print(e.toString());
        return left(Failure(e.toString()));
      }
    } else {
      return left(Failure('No internet connection'));
    }
  }
}
