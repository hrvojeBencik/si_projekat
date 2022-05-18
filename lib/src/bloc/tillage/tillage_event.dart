part of 'tillage_bloc.dart';

abstract class TillageEvent extends Equatable {
  const TillageEvent();

  @override
  List<Object> get props => [];
}

class LoadTillagesEvent extends TillageEvent {
  final String plotId;

  const LoadTillagesEvent(this.plotId);
}

class AddTillageEvent extends TillageEvent {
  final Tillage tillage;

  const AddTillageEvent(this.tillage);
}

class RemoveTillageEvent extends TillageEvent {}
