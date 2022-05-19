part of 'watering_bloc.dart';

abstract class WateringEvent extends Equatable {
  const WateringEvent();

  @override
  List<Object> get props => [];
}

class LoadWateringsEvent extends WateringEvent {
  final String plotId;

  const LoadWateringsEvent(this.plotId);
}

class AddWateringEvent extends WateringEvent {
  final Watering watering;

  const AddWateringEvent(this.watering);
}

class RemoveWateringEvent extends WateringEvent {
  final Watering watering;

  const RemoveWateringEvent(this.watering);
}
