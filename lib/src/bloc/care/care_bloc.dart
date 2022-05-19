import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:si_app/src/models/care.dart';
import 'package:si_app/src/services/api_service.dart';

part 'care_event.dart';
part 'care_state.dart';

class CareBloc extends Bloc<CareEvent, CareState> {
  final ApiService _apiService;
  List<Care> _cares = [];
  CareBloc(this._apiService) : super(LoadingCaresState()) {
    on<LoadCaresEvent>((event, emit) async {
      _cares = await _apiService.getCaresByPlot(event.plotId);
      _cares.sort((a, b) => a.date.compareTo(b.date));
      emit(CaresLoadedState(_cares));
    });

    on<AddCareEvent>((event, emit) async {
      Care? care = await _apiService.addNewCare(event.care);
      if (care != null) {
        _cares.add(care);
        emit(NewCareSuccessfullyAddedState());
      } else {
        emit(NewCareErrorState());
      }

      _cares.sort((a, b) => a.date.compareTo(b.date));
      emit(CaresLoadedState(_cares));
    });
  }
}
