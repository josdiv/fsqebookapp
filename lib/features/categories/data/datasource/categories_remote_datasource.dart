import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/failure/exceptions.dart';
import '../../../../core/utils/typedefs/typedefs.dart';
import '../model/category_entity_model.dart';
import '../model/sub_category_details_entity_model.dart';
import '../model/sub_category_entity_model.dart';

abstract interface class CategoriesRemoteDatasource {
  Future<List<CategoryEntityModel>> getCategories();

  Future<List<SubCategoryEntityModel>> getSubCategories(String id);

  Future<List<SubCategoryDetailsEntityModel>> getSubCategoriesDetails(
      String id);
}

const String kCategoriesEndpoint = '/categories.php?type=categories';
const String kSubCategoriesEndpoint = '/subcategory.php?type=subcategory';
const String kSubCategoriesDetailsEndpoint =
    '/subcategorydetail.php?type=subcategorydetail';

class CategoriesRemoteDatasourceImpl implements CategoriesRemoteDatasource {
  const CategoriesRemoteDatasourceImpl(this._client);

  final http.Client _client;

  @override
  Future<List<CategoryEntityModel>> getCategories() async {
    try {
      final response = await _client.post(
        Uri.parse("$kBaseUrl$kCategoriesEndpoint&authid=$authId"),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
          message: serverError,
          statusCode: response.statusCode,
        );
      }

      final body = jsonDecode(response.body) as DataMap;

      final status = body['status'] as String;

      if (status.toLowerCase() == 'failed' || status.toLowerCase() == 'error') {
        final message = body['message'] as String;
        throw APIException(
          message: message,
          statusCode: response.statusCode,
        );
      }

      final dynamicCategories = body['categoryList'] as List<dynamic>;
      return dynamicCategories
          .map(
            (latest) => CategoryEntityModel.fromJson(
              latest as DataMap,
            ),
          )
          .toList();
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 515);
    }
  }

  @override
  Future<List<SubCategoryEntityModel>> getSubCategories(String id) async {
    try {
      final response = await _client.post(
        Uri.parse("$kBaseUrl$kSubCategoriesEndpoint&authid=$authId&catId=$id"),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
          message: serverError,
          statusCode: response.statusCode,
        );
      }

      final body = jsonDecode(response.body) as DataMap;

      final status = body['status'] as String;

      if (status.toLowerCase() == 'failed' || status.toLowerCase() == 'error') {
        final message = body['message'] as String;
        throw APIException(
          message: message,
          statusCode: response.statusCode,
        );
      }

      final dynamicSubCategories = body['subCategoryList'] as List<dynamic>;
      return dynamicSubCategories
          .map(
            (subCat) => SubCategoryEntityModel.fromJson(
              subCat as DataMap,
            ),
          )
          .toList();
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 515);
    }
  }

  @override
  Future<List<SubCategoryDetailsEntityModel>> getSubCategoriesDetails(
      String id) async {
    try {
      final response = await _client.post(
        Uri.parse(
            "$kBaseUrl$kSubCategoriesDetailsEndpoint&authid=$authId&subcatId=$id"),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
          message: serverError,
          statusCode: response.statusCode,
        );
      }

      final body = jsonDecode(response.body) as DataMap;

      final status = body['status'] as String;

      if (status.toLowerCase() == 'failed' || status.toLowerCase() == 'error') {
        final message = body['message'] as String;
        throw APIException(
          message: message,
          statusCode: response.statusCode,
        );
      }

      final dynamicSubCategoriesDetails =
          body['subCategoyBookList'] as List<dynamic>;
      return dynamicSubCategoriesDetails
          .map(
            (subCat) => SubCategoryDetailsEntityModel.fromJson(
              subCat as DataMap,
            ),
          )
          .toList();
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 515);
    }
  }
}
