import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:si_app/src/models/tillage.dart';
import 'package:si_app/src/services/api_service.dart';

part 'tillage_event.dart';
part 'tillage_state.dart';

class TillageBloc extends Bloc<TillageEvent, TillageState> {
  final ApiService _apiService;
  List<Tillage> _tillages = [];
  TillageBloc(this._apiService) : super(LoadingTillagesState()) {
    on<LoadTillagesEvent>((event, emit) async {
      _tillages = await _apiService.getTillagesByPlot(event.plotId);
      _tillages.sort((a, b) => a.date.compareTo(b.date));
      emit(TillagesLoadedState(_tillages));
    });

    on<AddTillageEvent>((event, emit) async {
      Tillage? tillage = await _apiService.addNewTillage(event.tillage);
      if (tillage != null) {
        _tillages.add(tillage);
        emit(NewTillageSuccessfullyAddedState());
      } else {
        emit(NewTillageErrorState());
      }

      _tillages.sort((a, b) => a.date.compareTo(b.date));
      emit(TillagesLoadedState(_tillages));
    });
  }
}
