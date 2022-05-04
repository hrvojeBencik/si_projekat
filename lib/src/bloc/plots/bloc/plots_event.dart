part of 'plots_bloc.dart';

abstract class PlotsEvent extends Equatable {
  const PlotsEvent();

  @override
  List<Object> get props => [];
}

class FetchPlotsEvent extends PlotsEvent {}

class AddNewPlotEvent extends PlotsEvent {}

class SubmitAddingNewPlotEvent extends PlotsEvent {}

class CancelAddingNewPlotEvent extends PlotsEvent {}
