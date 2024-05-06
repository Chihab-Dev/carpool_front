import 'package:carpool/app/localizations.dart';
import 'package:carpool/app/service_locator.dart';
import 'package:carpool/app/shared_prefrences.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/screens/Client/home/cubit/home_cubit.dart';
import 'package:carpool/presentation/screens/Client/main/view/main_view.dart';
import 'package:carpool/presentation/screens/Driver/home/cubit/driver_home_cubit.dart';
import 'package:carpool/presentation/screens/Driver/main/view/driver_main_view.dart';
import 'package:carpool/presentation/screens/auth/travellerOrDriver/travellerOrDriver.dart';
import 'package:carpool/presentation/screens/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServiceLocator().init();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final AppPrefences _appPrefences = AppPrefences(getIt());

  @override
  Widget build(BuildContext context) {
    _appPrefences.removeId();
    _appPrefences.removeIsClient();
    bool isOnboardingWatched = _appPrefences.getWatchedOnBoarding();
    String id = _appPrefences.getId();
    bool isClient = _appPrefences.getIsClient();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => DriverHomeCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: const Locale('en'),
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
                    : isClient
                        ? const MainView()
                        : const DriverMainView()
                : OnboardingView(),
          );
        },
      ),
    );
  }
}
