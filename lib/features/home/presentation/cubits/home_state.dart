part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState([this.model = const HomeModel.initial()]);

  final HomeModel model;

  @override
  List<Object> get props => [model];
}

final class HomeInitial extends HomeState {}

final class HomeScreenState extends HomeState {
  const HomeScreenState(super.model);
}

final class ByPassLoading extends HomeState {}

final class ByPassError extends HomeState {
  const ByPassError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

final class ByPassSuccess extends HomeState {
  const ByPassSuccess(this.entity);

  final ByPassEntity entity;

  @override
  List<Object> get props => [entity];
}
