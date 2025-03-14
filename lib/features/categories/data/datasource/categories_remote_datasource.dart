import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/failure/exceptions.dart';
import '../../../../core/utils/typedefs/typedefs.dart';
import '../model/category_entity_model.dart';

abstract interface class CategoriesRemoteDatasource {
  Future<List<CategoryEntityModel>> getCategories();
}

const String kCategoriesEndpoint = '/categories.php';

class CategoriesRemoteDatasourceImpl implements CategoriesRemoteDatasource {
  const CategoriesRemoteDatasourceImpl(this._client);

  final http.Client _client;

  @override
  Future<List<CategoryEntityModel>> getCategories() async {
    try {
      final response = await _client.post(
        Uri.parse("$kBaseUrl$kCategoriesEndpoint"),
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
        throw ServerException(
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
}
