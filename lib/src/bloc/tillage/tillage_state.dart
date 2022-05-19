part of 'tillage_bloc.dart';

abstract class TillageState extends Equatable {
  const TillageState();

  @override
  List<Object> get props => [];
}

class LoadingTillagesState extends TillageState {}

class TillagesLoadedState extends TillageState {
  final List<Tillage> tillages;

  const TillagesLoadedState(this.tillages);
}

class NewTillageSuccessfullyAddedState extends TillageState {}

class NewTillageErrorState extends TillageState {}

class SuccessfullDelete extends TillageState {}
