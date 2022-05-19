import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:si_app/src/models/yield.dart';
import 'package:si_app/src/services/api_service.dart';

part 'yield_event.dart';
part 'yield_state.dart';

class YieldBloc extends Bloc<YieldEvent, YieldState> {
  final ApiService _apiService;
  List<Yield> _yields = [];
  YieldBloc(this._apiService) : super(LoadingYieldsState()) {
    on<LoadYieldsEvent>((event, emit) async {
      _yields = await _apiService.getYieldsByPlot(event.plotId);
      _yields.sort((a, b) => a.date.compareTo(b.date));
      emit(YieldsLoadedState(_yields));
    });

    on<AddYieldEvent>((event, emit) async {
      Yield? y = await _apiService.addNewYield(event.y);
      if (y != null) {
        _yields.add(y);
        emit(NewYieldSuccessfullyAddedState());
      } else {
        emit(NewYieldErrorState());
      }

      _yields.sort((a, b) => a.date.compareTo(b.date));
      emit(YieldsLoadedState(_yields));
    });
  }
}
