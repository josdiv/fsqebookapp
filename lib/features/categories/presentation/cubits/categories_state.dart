part of 'categories_cubit.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState([this.model = const CategoriesModel.initial()]);

  final CategoriesModel model;

  @override
  List<Object> get props => [model];
}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesScreenState extends CategoriesState {
  const CategoriesScreenState(super.model);
}
