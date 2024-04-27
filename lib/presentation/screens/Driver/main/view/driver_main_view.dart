import 'package:carpool/app/localizations.dart';
import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/screens/Driver/main/cubit/driver_main_cubit.dart';
import 'package:carpool/presentation/screens/Driver/main/cubit/driver_main_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class DriverMainView extends StatefulWidget {
  const DriverMainView({super.key});

  @override
  State<DriverMainView> createState() => _DriverMainViewState();
}

class _DriverMainViewState extends State<DriverMainView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverMainCubit(),
      child: BlocConsumer<DriverMainCubit, DriverMainStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = DriverMainCubit.get(context);
          return Scaffold(
            body: Center(
              child: cubit.pages[cubit.currentIndex],
            ),
            bottomNavigationBar: bottomNavigationBar(cubit),
          );
        },
      ),
    );
  }

  Widget bottomNavigationBar(DriverMainCubit cubit) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.inner,
            blurRadius: 3,
            offset: const Offset(0, 0),
            color: ColorManager.darkGrey,
          )
        ],
      ),
      child: GNav(
        backgroundColor: ColorManager.white,
        color: ColorManager.darkGrey,
        activeColor: ColorManager.white,
        tabBackgroundColor: ColorManager.yellow,
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p16),
        tabMargin: EdgeInsets.symmetric(horizontal: AppPadding.p25, vertical: AppPadding.p14),
        gap: AppSize.s20,
        onTabChange: (value) => cubit.onTap(value),
        textStyle: getMeduimStyle(color: ColorManager.white).copyWith(fontSize: AppSize.s15),
        tabs: [
          GButton(
            icon: Icons.add_circle_outline,
            text: AppStrings.newTravel.tr(context),
          ),
          GButton(
            icon: Icons.local_taxi_outlined,
            text: AppStrings.yourRide.tr(context),
          ),
          GButton(
            icon: Icons.person_outline_rounded,
            text: AppStrings.account.tr(context),
          ),
        ],
      ),
    );
  }
}
