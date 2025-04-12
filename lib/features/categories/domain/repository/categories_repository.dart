import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/entity/category_entity.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/entity/sub_category_details_entity.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/entity/sub_category_entity.dart';

abstract interface class CategoriesRepository {
  ResultFuture<List<CategoryEntity>> getCategories();
  ResultFuture<List<SubCategoryEntity>> getSubCategories(String id);
  ResultFuture<List<SubCategoryDetailsEntity>> getSubCategoriesDetails(String id);
}
