part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeSearchForLocation extends HomeState {}

final class HomeChooseLocation extends HomeState {}

final class HomePickDateState extends HomeState {}

final class HomePickNumberOfPlacesState extends HomeState {}

final class HomeGetTravelLoadingState extends HomeState {}

final class HomeGetTravelSuccessState extends HomeState {}

final class HomeGetTravelErrorState extends HomeState {}

final class HomeGetClientLoadingState extends HomeState {}

final class HomeGetClientSuccessState extends HomeState {}

final class HomeGetClientErrorState extends HomeState {}

final class HomeRequestToBookLoadingState extends HomeState {}

final class HomeRequestToBookSuccessState extends HomeState {}

final class HomeRequestToBookErrorState extends HomeState {}

final class HomeChangeRatingState extends HomeState {}

final class HomeChangeValidationState extends HomeState {}

final class HomeSendFeedbackLoadingState extends HomeState {}

final class HomeSendFeedbackSuccessState extends HomeState {}

final class HomeSendFeedbackErrorState extends HomeState {}

final class HomeCalculateAcceptedRequestsState extends HomeState {}
