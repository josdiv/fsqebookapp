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
