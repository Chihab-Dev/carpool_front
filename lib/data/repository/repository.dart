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

  @override
  Future<Either<Failure, void>> createTravel(TravelModel travelModel) async {
    if (await networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.createTravel(travelModel);
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
  Future<Either<Failure, AdminModel>> adminLogin(String phoneNumber, String password) async {
    if (await networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.adminLogin(phoneNumber, password);
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
  Future<Either<Failure, List<ClientModel>>> getAllClients() async {
    if (await networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.getAllClients();
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
  Future<Either<Failure, List<DriverModel>>> getAllDrivers() async {
    if (await networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.getAllDrivers();
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
  Future<Either<Failure, List<TravelModel>>> getAllTravels() async {
    if (await networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.getAllTravels();
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
  Future<Either<Failure, void>> acceptDriver(String id) async {
    if (await networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.acceptDriver(id);
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
  Future<Either<Failure, void>> rejectDriver(String id) async {
    if (await networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.rejectDriver(id);
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
  Future<Either<Failure, void>> deleteDriver(String id) async {
    if (await networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.deleteDriver(id);
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
  Future<Either<Failure, void>> deleteClient(String id) async {
    if (await networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.deleteClient(id);
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
  Future<Either<Failure, void>> deleteTravel(String id) async {
    if (await networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.deleteTravel(id);
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
  Future<Either<Failure, void>> clientSendFeedback(FeedbackModel feedback) async {
    if (await networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.clientSendFeedback(feedback);
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
  Future<Either<Failure, void>> driverSendFeedback(FeedbackModel feedback) async {
    if (await networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.driverSendFeedback(feedback);
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
  Future<Either<Failure, void>> updateTravel(TravelModel travel) async {
    if (await networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.updateTravel(travel);
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
  Future<Either<Failure, TravelModel>> clientGetTravelById(String id) async {
    if (await networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.clientGetTravelById(id);
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
  Future<Either<Failure, List<TravelModel>>> driverGetTravelById() async {
    if (await networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.driverGetTravelById();
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
  Future<Either<Failure, void>> updateRequestState(String state, String requestId, String travelId) async {
    if (await networkInfo.isConnected()) {
      try {
        final result = await remoteDataSource.updateRequestState(state, requestId, travelId);
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
