part of 'plots_bloc.dart';

abstract class PlotsEvent extends Equatable {
  const PlotsEvent();

  @override
  List<Object> get props => [];
}

class FetchPlotsEvent extends PlotsEvent {}

class OpenNewPlotFormEvent extends PlotsEvent {}

class AddNewPlotEvent extends PlotsEvent {
  final Plot plot;

  const AddNewPlotEvent(this.plot);
}

class SubmitAddingNewPlotEvent extends PlotsEvent {}

class CancelAddingNewPlotEvent extends PlotsEvent {}
