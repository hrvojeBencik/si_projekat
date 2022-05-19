import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:si_app/config/api.dart';
import 'package:si_app/src/models/plot.dart';
import 'package:si_app/src/services/api_service.dart';

part 'plots_event.dart';
part 'plots_state.dart';

class PlotsBloc extends Bloc<PlotsEvent, PlotsState> {
  ApiService apiService;
  List<Plot> plots = [];
  PlotsBloc(this.apiService) : super(PlotsLoadingState()) {
    on<FetchPlotsEvent>((event, emit) async {
      plots = await apiService.getAllPlots();

      emit(PlotsLoadedState(plots));
    });

    on<OpenNewPlotFormEvent>((event, emit) {
      emit(AddingNewPlotState());
    });

    on<CancelAddingNewPlotEvent>((event, emit) {
      emit(PlotsLoadedState(plots));
    });

    on<AddNewPlotEvent>((event, emit) async {
      plots.add(event.plot);
      await apiService.addNewPlot(event.plot);

      add(FetchPlotsEvent());
    });

    on<RemovePlotEvent>((event, emit) async {
      await apiService.deleteInstanceById(plotsEndpoint, event.plot.id!);
      plots.removeWhere((element) => element.id! == event.plot.id!);
      emit(SuccessfulDelete());
      emit(PlotsLoadedState(plots));
    });
  }

  void clearPlotList() => plots.clear();
}
