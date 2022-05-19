part of 'care_bloc.dart';

abstract class CareState extends Equatable {
  const CareState();

  @override
  List<Object> get props => [];
}

class LoadingCaresState extends CareState {}

class CaresLoadedState extends CareState {
  final List<Care> cares;

  const CaresLoadedState(this.cares);
}

class NewCareSuccessfullyAddedState extends CareState {}

class NewCareErrorState extends CareState {}

class SuccessfullDelete extends CareState {}
