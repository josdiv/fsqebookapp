part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState([this.loaded = false]);

  final bool loaded;

  @override
  List<Object> get props => [loaded];
}

final class HomeInitial extends HomeState {}

final class HomeDataLoading extends HomeState {
  const HomeDataLoading();
}

final class HomeDataError extends HomeState {
  const HomeDataError(this.error);

  final String error;

  @override
  List<Object> get props => [...super.props, error];
}

final class HomeDataLoaded extends HomeState {
  const HomeDataLoaded(this.entity, super.loaded);

  final HomeEntity entity;

  @override
  List<Object> get props => [...super.props, entity];
}
