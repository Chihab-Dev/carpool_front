import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/screens/main/cubit/main_cubit.dart';
import 'package:carpool/presentation/screens/main/cubit/main_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: BlocConsumer<MainCubit, MainStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MainCubit.get(context);
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

  Widget bottomNavigationBar(MainCubit cubit) {
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
        padding: EdgeInsets.all(AppPadding.p16),
        tabMargin: EdgeInsets.symmetric(horizontal: AppPadding.p14, vertical: AppPadding.p14),
        gap: AppSize.s15,
        onTabChange: (value) => cubit.onTap(value),
        textStyle: getMeduimStyle(color: ColorManager.white).copyWith(fontSize: AppSize.s15),
        tabs: [
          GButton(
            icon: Icons.home_outlined,
            text: AppStrings.home,
          ),
          GButton(
            icon: Icons.message_outlined,
            text: AppStrings.message,
          ),
          GButton(
            icon: Icons.local_taxi_outlined,
            text: AppStrings.yourRide,
          ),
          GButton(
            icon: Icons.person_outline_rounded,
            text: AppStrings.account,
          ),
        ],
      ),
    );
  }
}
