part of 'watering_bloc.dart';

abstract class WateringState extends Equatable {
  const WateringState();

  @override
  List<Object> get props => [];
}

class LoadingWateringsState extends WateringState {}

class WateringsLoadedState extends WateringState {
  final List<Watering> waterings;

  const WateringsLoadedState(this.waterings);
}

class NewWateringSuccessfullyAddedState extends WateringState {}

class NewWateringErrorState extends WateringState {}

class SuccessfullDelete extends WateringState {}
