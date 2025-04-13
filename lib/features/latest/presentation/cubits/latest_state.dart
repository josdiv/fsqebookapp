part of 'latest_cubit.dart';

sealed class LatestState extends Equatable {
  const LatestState([this.model = const LatestModel.initial()]);

  final LatestModel model;

  @override
  List<Object> get props => [model];
}

final class LatestInitial extends LatestState {}


final class LatestScreenState extends LatestState {
  const LatestScreenState(super.model);
}

