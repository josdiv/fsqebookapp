import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/failure/exceptions.dart';
import '../../../../core/utils/typedefs/typedefs.dart';
import '../model/author_details_entity_model.dart';
import '../model/author_entity_model.dart';

abstract interface class AuthorsRemoteDatasource {
  Future<List<AuthorEntityModel>> getAuthors();

  Future<AuthorDetailsEntityModel> getSingleAuthor(String id);
}

const String kAuthorsEndpoint = '/author.php?type=author';
const String kSingleAuthorsEndpoint = '/authordetail.php?type=authordetail';

class AuthorsRemoteDatasourceImpl implements AuthorsRemoteDatasource {
  const AuthorsRemoteDatasourceImpl(this._client);

  final http.Client _client;

  @override
  Future<List<AuthorEntityModel>> getAuthors() async {
    try {
      final response = await _client.post(
        Uri.parse("$kBaseUrl$kAuthorsEndpoint&authid=$authId"),
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

  @override
  Future<AuthorDetailsEntityModel> getSingleAuthor(String id) async {
    try {
      final response = await _client.post(
        Uri.parse("$kBaseUrl$kSingleAuthorsEndpoint&authid=$authId&authorId=$id"),
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

      return AuthorDetailsEntityModel.fromJson(body);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 515);
    }
  }
}
