abstract class UpdateTravelState {}

class UpdateTravelInitialState extends UpdateTravelState {}

final class UpdateTravelSearchForLocation extends UpdateTravelState {}

final class UpdateTravelChooseLocation extends UpdateTravelState {}

final class UpdateTravelPickTime extends UpdateTravelState {}

final class UpdateTravelPickNumberOfSeats extends UpdateTravelState {}

final class UpdateTravelPickPersonPrice extends UpdateTravelState {}

final class UpdateTravelPickBaggageSize extends UpdateTravelState {}

final class UpdateTravelPickPetsAllowed extends UpdateTravelState {}

final class UpdateTravelPickSmokingAllowed extends UpdateTravelState {}

final class UpdateTravelPickDate extends UpdateTravelState {}

final class UpdateTravelPickImage extends UpdateTravelState {}

final class UpdateTravelLoadingState extends UpdateTravelState {}

final class UpdateTravelSuccessState extends UpdateTravelState {}

final class UpdateTravelErrorState extends UpdateTravelState {}

final class UpdateTravelCheckValidationState extends UpdateTravelState {}
