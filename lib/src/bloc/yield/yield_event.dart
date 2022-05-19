part of 'yield_bloc.dart';

abstract class YieldEvent extends Equatable {
  const YieldEvent();

  @override
  List<Object> get props => [];
}

class LoadYieldsEvent extends YieldEvent {
  final String plotId;

  const LoadYieldsEvent(this.plotId);
}

class AddYieldEvent extends YieldEvent {
  final Yield y;

  const AddYieldEvent(this.y);
}

class RemoveYieldEvent extends YieldEvent {
  final Yield y;

  const RemoveYieldEvent(this.y);
}
