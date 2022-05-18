import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:si_app/src/models/watering.dart';
import 'package:si_app/src/services/api_service.dart';

part 'watering_event.dart';
part 'watering_state.dart';

class WateringBloc extends Bloc<WateringEvent, WateringState> {
  final ApiService _apiService;
  List<Watering> _waterings = [];
  WateringBloc(this._apiService) : super(LoadingWateringsState()) {
    on<LoadWateringsEvent>((event, emit) async {
      _waterings = await _apiService.getWateringsByPlot(event.plotId);
      emit(WateringsLoadedState(_waterings));
    });

    on<AddWateringEvent>((event, emit) async {
      Watering? watering = await _apiService.addNewWatering(event.watering);
      if (watering != null) {
        _waterings.add(watering);
        emit(NewWateringSuccessfullyAddedState());
      } else {
        emit(NewWateringErrorState());
      }
      emit(WateringsLoadedState(_waterings));
    });
  }
}
