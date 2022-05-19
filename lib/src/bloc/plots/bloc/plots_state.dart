part of 'plots_bloc.dart';

abstract class PlotsState extends Equatable {
  const PlotsState();

  @override
  List<Object> get props => [];
}

class PlotsLoadingState extends PlotsState {}

class PlotsLoadedState extends PlotsState {
  final List<Plot> plots;

  const PlotsLoadedState(this.plots);
}

class AddingNewPlotState extends PlotsState {}

class SuccessfullyAddedPlotState extends PlotsState {}
