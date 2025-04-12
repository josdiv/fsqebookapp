import 'package:dartz/dartz.dart';
import 'package:foursquare_ebbok_app/core/failure/exceptions.dart';
import 'package:foursquare_ebbok_app/core/failure/failure.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/categories/data/datasource/categories_remote_datasource.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/entity/category_entity.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/entity/sub_category_details_entity.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/entity/sub_category_entity.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/repository/categories_repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  const CategoriesRepositoryImpl(this._remoteDatasource);

  final CategoriesRemoteDatasource _remoteDatasource;

  @override
  ResultFuture<List<CategoryEntity>> getCategories() async {
    try {
      final result = await _remoteDatasource.getCategories();
      return Right(result);
    } on APIException catch (e) {
      return Left(
        APIFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<List<SubCategoryEntity>> getSubCategories(String id) async {
    try {
      final result = await _remoteDatasource.getSubCategories(id);
      return Right(result);
    } on APIException catch (e) {
      return Left(
        APIFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<List<SubCategoryDetailsEntity>> getSubCategoriesDetails(
      String id) async {
    try {
      final result = await _remoteDatasource.getSubCategoriesDetails(id);
      return Right(result);
    } on APIException catch (e) {
      return Left(
        APIFailure.fromException(e),
      );
    }
  }
}
