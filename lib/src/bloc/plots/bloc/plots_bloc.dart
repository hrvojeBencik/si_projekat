import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:si_app/src/models/plot.dart';

part 'plots_event.dart';
part 'plots_state.dart';

class PlotsBloc extends Bloc<PlotsEvent, PlotsState> {
  List<Plot> plots = [];
  PlotsBloc() : super(PlotsLoadingState()) {
    on<FetchPlotsEvent>((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      emit(PlotsLoadedState(plots));
    });

    on<AddNewPlotEvent>((event, emit) {
      emit(AddingNewPlotState());
    });

    on<CancelAddingNewPlotEvent>((event, emit) {
      emit(PlotsLoadedState(plots));
    });
  }
}
