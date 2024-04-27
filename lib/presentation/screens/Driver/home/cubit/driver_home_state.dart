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
