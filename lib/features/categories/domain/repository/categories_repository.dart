import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/entity/category_entity.dart';

abstract interface class CategoriesRepository {
  ResultFuture<List<CategoryEntity>> getCategories();
}
