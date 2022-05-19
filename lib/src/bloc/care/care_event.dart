part of 'care_bloc.dart';

abstract class CareEvent extends Equatable {
  const CareEvent();

  @override
  List<Object> get props => [];
}

class LoadCaresEvent extends CareEvent {
  final String plotId;

  const LoadCaresEvent(this.plotId);
}

class AddCareEvent extends CareEvent {
  final Care care;

  const AddCareEvent(this.care);
}

class RemoveCareEvent extends CareEvent {
  final Care care;

  const RemoveCareEvent(this.care);
}
