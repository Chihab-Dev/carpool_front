import 'package:carpool/presentation/screens/Client/home/view/client_profile_view.dart';
import 'package:carpool/presentation/screens/Client/home/view/home_view.dart';
import 'package:carpool/presentation/screens/Client/main/cubit/main_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainIntialStates());

  static MainCubit get(context) => BlocProvider.of(context);

  // home screen ::

  int currentIndex = 0;

  List<Widget> pages = [
    const HomeView(),
    const SizedBox(),
    const ClientProfileView(),
  ];

  void onTap(int index) {
    currentIndex = index;
    emit(MainChangeIndexState());
  }
}
