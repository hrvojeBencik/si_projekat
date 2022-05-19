import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:si_app/src/models/supplementation.dart';
import 'package:si_app/src/services/api_service.dart';

part 'supplementation_event.dart';
part 'supplementation_state.dart';

class SupplementationBloc extends Bloc<SupplementationEvent, SupplementationState> {
  final ApiService _apiService;
  List<Supplementation> _supplementations = [];
  SupplementationBloc(this._apiService) : super(LoadingSupplementationsState()) {
    on<LoadSupplementationsEvent>((event, emit) async {
      _supplementations = await _apiService.getSupplementationsByPlot(event.plotId);
      _supplementations.sort((a, b) => a.date.compareTo(b.date));
      emit(SupplementationsLoadedState(_supplementations));
    });

    on<AddSupplementationEvent>((event, emit) async {
      Supplementation? supplementation = await _apiService.addNewSupplementation(event.supplementation);
      if (supplementation != null) {
        _supplementations.add(supplementation);
        emit(NewSupplementationSuccessfullyAddedState());
      } else {
        emit(NewSupplementationErrorState());
      }

      _supplementations.sort((a, b) => a.date.compareTo(b.date));
      emit(SupplementationsLoadedState(_supplementations));
    });
  }
}
