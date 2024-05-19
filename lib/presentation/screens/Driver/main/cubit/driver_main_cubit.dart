import 'package:carpool/presentation/screens/Driver/home/view/driver_all_travels.dart';
import 'package:carpool/presentation/screens/Driver/home/view/driver_new_travel_view.dart';
import 'package:carpool/presentation/screens/Driver/home/view/driver_profile_view.dart';
import 'package:carpool/presentation/screens/Driver/main/cubit/driver_main_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverMainCubit extends Cubit<DriverMainStates> {
  DriverMainCubit() : super(DriverMainIntialStates());

  static DriverMainCubit get(context) => BlocProvider.of(context);

  // home screen ::

  int currentIndex = 0;

  List<Widget> pages = [
    const DriverHomeView(),
    const DriverAllTravelsView(),
    const DriverProfileView(),
  ];

  void onTap(int index) {
    currentIndex = index;
    emit(DriverMainChangeIndexState());
  }
}
