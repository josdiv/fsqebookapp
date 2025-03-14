import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/entity/category_entity.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/repository/categories_repository.dart';

class GetCategories implements UsecaseWithoutParams<List<CategoryEntity>> {
  const GetCategories(this._repository);

  final CategoriesRepository _repository;

  @override
  ResultFuture<List<CategoryEntity>> call() async =>
      _repository.getCategories();
}
