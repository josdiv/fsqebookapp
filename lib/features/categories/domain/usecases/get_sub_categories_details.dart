import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/repository/categories_repository.dart';

import '../entity/sub_category_details_entity.dart';

class GetSubCategoriesDetails
    implements UsecaseWithParams<List<SubCategoryDetailsEntity>, String> {
  const GetSubCategoriesDetails(this._repository);

  final CategoriesRepository _repository;

  @override
  ResultFuture<List<SubCategoryDetailsEntity>> call(String params) async =>
      _repository.getSubCategoriesDetails(params);
}
