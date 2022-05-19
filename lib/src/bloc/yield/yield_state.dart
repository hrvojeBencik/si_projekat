part of 'yield_bloc.dart';

abstract class YieldState extends Equatable {
  const YieldState();

  @override
  List<Object> get props => [];
}

class LoadingYieldsState extends YieldState {}

class YieldsLoadedState extends YieldState {
  final List<Yield> yields;

  const YieldsLoadedState(this.yields);
}

class NewYieldSuccessfullyAddedState extends YieldState {}

class NewYieldErrorState extends YieldState {}

class SuccessfullDelete extends YieldState {}
