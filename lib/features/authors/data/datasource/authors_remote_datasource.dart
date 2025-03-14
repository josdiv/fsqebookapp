import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/failure/exceptions.dart';
import '../../../../core/utils/typedefs/typedefs.dart';
import '../model/author_entity_model.dart';

abstract interface class AuthorsRemoteDatasource {
  Future<List<AuthorEntityModel>> getAuthors();
}

const String kAuthorsEndpoint = '/author.php';

class AuthorsRemoteDatasourceImpl implements AuthorsRemoteDatasource {
  const AuthorsRemoteDatasourceImpl(this._client);

  final http.Client _client;

  @override
  Future<List<AuthorEntityModel>> getAuthors() async {
    try {
      final response = await _client.post(
        Uri.parse("$kBaseUrl$kAuthorsEndpoint"),
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

      final dynamicAuthors = body['authorList'] as List<dynamic>;
      return dynamicAuthors
          .map(
            (author) => AuthorEntityModel.fromJson(
              author as DataMap,
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
