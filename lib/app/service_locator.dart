import 'package:carpool/app/shared_prefrences.dart';
import 'package:carpool/data/data_source/remote_data_source.dart';
import 'package:carpool/data/network/network_info.dart';
import 'package:carpool/data/repository/repository.dart';
import 'package:carpool/domain/repository/repository.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    // shared prefrences
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
    getIt.registerLazySingleton<AppPrefences>(() => AppPrefences(getIt()));

    // network info
    getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));

    // remote data source
    getIt.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl());

    // remote data source
    getIt.registerLazySingleton<Repository>(
        () => RepositoryImpl(networkInfo: getIt<NetworkInfo>(), remoteDataSource: getIt<RemoteDataSource>()));
  }
}
