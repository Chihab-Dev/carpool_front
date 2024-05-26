import 'package:carpool/app/localizations.dart';
import 'package:carpool/app/service_locator.dart';
import 'package:carpool/app/shared_prefrences.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/screens/Client/home/cubit/home_cubit.dart';
import 'package:carpool/presentation/screens/Client/main/view/main_view.dart';
import 'package:carpool/presentation/screens/Driver/home/cubit/driver_home_cubit.dart';
import 'package:carpool/presentation/screens/Driver/main/view/driver_main_view.dart';
import 'package:carpool/presentation/screens/Driver/update%20travel/cubit/cubit.dart';
import 'package:carpool/presentation/screens/admin/cubit/cubit.dart';
import 'package:carpool/presentation/screens/admin/screens/main.dart';
import 'package:carpool/presentation/screens/auth/travellerOrDriver/travellerOrDriver.dart';
import 'package:carpool/presentation/screens/onboarding/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServiceLocator().init();

  await Firebase.initializeApp();
  runApp(Phoenix(child: MainApp()));
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final AppPrefences _appPrefences = AppPrefences(getIt());

  @override
  Widget build(BuildContext context) {
    // _appPrefences.removeId();
    // _appPrefences.removeRole();
    // _appPrefences.removeToken();
    bool isOnboardingWatched = _appPrefences.getWatchedOnBoarding();
    String id = _appPrefences.getId();
    String role = _appPrefences.getRole();

    // RemoteDataSource remoteDataSource = RemoteDataSourceImpl();

    // remoteDataSource.clientLogin('0656933390', 'password');

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => DriverHomeCubit(),
        ),
        BlocProvider(
          create: (context) => AdminCubit(),
        ),
        BlocProvider(
          create: (context) => UpdateTravelCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (context, child) {
          String lang = _appPrefences.getLangugage();

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: Locale(lang),
            theme: ThemeData(
              scaffoldBackgroundColor: ColorManager.white,
            ),
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            home: isOnboardingWatched
                ? id == ''
                    ? const TravellerOrDriverView()
                    : role == 'client'
                        ? const MainView()
                        : role == 'driver'
                            ? const DriverMainView()
                            : role == 'admin'
                                ? const AdminMainView()
                                : const TravellerOrDriverView()
                : OnboardingView(),
          );
        },
      ),
    );
  }
}
