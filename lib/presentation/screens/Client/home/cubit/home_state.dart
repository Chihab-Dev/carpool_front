part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeSearchForLocation extends HomeState {}

final class HomeChooseLocation extends HomeState {}

final class HomePickDateState extends HomeState {}

final class HomePickNumberOfPlacesState extends HomeState {}
