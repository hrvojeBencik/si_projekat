part of 'supplementation_bloc.dart';

abstract class SupplementationState extends Equatable {
  const SupplementationState();

  @override
  List<Object> get props => [];
}

class LoadingSupplementationsState extends SupplementationState {}

class SupplementationsLoadedState extends SupplementationState {
  final List<Supplementation> supplementations;

  const SupplementationsLoadedState(this.supplementations);
}

class NewSupplementationSuccessfullyAddedState extends SupplementationState {}

class NewSupplementationErrorState extends SupplementationState {}

class SuccessfullDelete extends SupplementationState {}
