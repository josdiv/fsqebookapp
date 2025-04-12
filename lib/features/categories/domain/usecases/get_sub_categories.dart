import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/repository/categories_repository.dart';

import '../entity/sub_category_entity.dart';

class GetSubCategories
    implements UsecaseWithParams<List<SubCategoryEntity>, String> {
  const GetSubCategories(this._repository);

  final CategoriesRepository _repository;

  @override
  ResultFuture<List<SubCategoryEntity>> call(String params) async =>
      _repository.getSubCategories(params);
}
