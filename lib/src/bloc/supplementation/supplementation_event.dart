part of 'supplementation_bloc.dart';

abstract class SupplementationEvent extends Equatable {
  const SupplementationEvent();

  @override
  List<Object> get props => [];
}

class LoadSupplementationsEvent extends SupplementationEvent {
  final String plotId;

  const LoadSupplementationsEvent(this.plotId);
}

class AddSupplementationEvent extends SupplementationEvent {
  final Supplementation supplementation;

  const AddSupplementationEvent(this.supplementation);
}

class RemoveSupplementationEvent extends SupplementationEvent {}
