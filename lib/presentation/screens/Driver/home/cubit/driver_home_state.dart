part of 'driver_home_cubit.dart';

@immutable
sealed class DriverHomeState {}

final class DriverHomeInitial extends DriverHomeState {}

final class DriverHomeSearchForLocation extends DriverHomeState {}

final class DriverHomeChooseLocation extends DriverHomeState {}

final class DriverHomePickTime extends DriverHomeState {}

final class DriverHomePickNumberOfSeats extends DriverHomeState {}

final class DriverHomePickPersonPrice extends DriverHomeState {}

final class DriverHomePickBaggageSize extends DriverHomeState {}

final class DriverHomePickPetsAllowed extends DriverHomeState {}

final class DriverHomePickSmokingAllowed extends DriverHomeState {}

final class DriverHomePickDate extends DriverHomeState {}

final class DriverHomePickImage extends DriverHomeState {}

final class DriverCreateTravelLoadingState extends DriverHomeState {}

final class DriverCreateTravelSuccessState extends DriverHomeState {}

final class DriverCreateTravelErrorState extends DriverHomeState {}

final class DriverCheckValidationState extends DriverHomeState {}

final class DriverGetDriverLoadingState extends DriverHomeState {}

final class DriverGetDriverSuccessState extends DriverHomeState {}

final class DriverGetDriverErrorState extends DriverHomeState {}

final class DriverChangeRatingState extends DriverHomeState {}

final class DriverChangeValidationState extends DriverHomeState {}

final class DriverSendFeedbackLoadingState extends DriverHomeState {}

final class DriverSendFeedbackSuccessState extends DriverHomeState {}

final class DriverSendFeedbackErrorState extends DriverHomeState {}

final class DriverGetTravelByIdLoadingState extends DriverHomeState {}

final class DriverGetTravelByIdSuccessState extends DriverHomeState {}

final class DriverGetTravelByIdErrorState extends DriverHomeState {}
