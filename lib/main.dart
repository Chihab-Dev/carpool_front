import 'package:carpool/app/localizations.dart';
import 'package:carpool/app/service_locator.dart';
import 'package:carpool/app/shared_prefrences.dart';
import 'package:carpool/presentation/screens/home/cubit/home_cubit.dart';
import 'package:carpool/presentation/screens/main/view/main_view.dart';
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
    bool isOnboardingWatched = _appPrefences.getWatchedOnBoarding();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
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
            home: isOnboardingWatched ? const MainView() : OnboardingView(),
          );
        },
      ),
    );
  }
}
