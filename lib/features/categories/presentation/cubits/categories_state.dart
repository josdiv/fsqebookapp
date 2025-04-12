part of 'categories_cubit.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoadingState extends CategoriesState {}
final class CategoriesErrorState extends CategoriesState {
  const CategoriesErrorState(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
final class CategoriesLoadedState extends CategoriesState {
  const CategoriesLoadedState(this.categories);

  final List<CategoryEntity> categories;

  @override
  List<Object> get props => [categories];
}

final class SubCategoriesLoadingState extends CategoriesState {}
final class SubCategoriesErrorState extends CategoriesState {
  const SubCategoriesErrorState(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
final class SubCategoriesLoadedState extends CategoriesState {
  const SubCategoriesLoadedState(this.subCategories);

  final List<SubCategoryEntity> subCategories;

  @override
  List<Object> get props => [subCategories];
}

final class SubCategoriesDetailsLoadingState extends CategoriesState {}
final class SubCategoriesDetailsErrorState extends CategoriesState {
  const SubCategoriesDetailsErrorState(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
final class SubCategoriesDetailsLoadedState extends CategoriesState {
  const SubCategoriesDetailsLoadedState(this.subCategoriesDetails);

  final List<SubCategoryDetailsEntity> subCategoriesDetails;

  @override
  List<Object> get props => [subCategoriesDetails];
}