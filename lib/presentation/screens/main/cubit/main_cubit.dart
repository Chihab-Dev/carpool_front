import 'package:carpool/presentation/screens/home/view/home_view.dart';
import 'package:carpool/presentation/screens/main/cubit/main_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainIntialStates());

  static MainCubit get(context) => BlocProvider.of(context);

  // home screen ::

  int currentIndex = 0;

  List<Widget> pages = [
    const HomeView(),
    Container(),
    const SizedBox(),
  ];

  void onTap(int index) {
    currentIndex = index;
    emit(MainChangeIndexState());
  }
}
