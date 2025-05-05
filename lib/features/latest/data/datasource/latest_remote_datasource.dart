import 'dart:convert';

import 'package:foursquare_ebbok_app/core/constants/constants.dart';
import 'package:foursquare_ebbok_app/core/failure/exceptions.dart';
import 'package:foursquare_ebbok_app/features/latest/data/models/latest_entity_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/typedefs/typedefs.dart';

abstract interface class LatestRemoteDatasource {
  Future<List<LatestEntityModel>> getLatestBooks();
}

const String kLatestEndpoint = '/latestbooks.php';

class LatestRemoteDatasourceImpl implements LatestRemoteDatasource {
  const LatestRemoteDatasourceImpl(this._client);

  final http.Client _client;

  @override
  Future<List<LatestEntityModel>> getLatestBooks() async {
    try {
      final response = await _client.post(
        Uri.parse("$kBaseUrl$kLatestEndpoint?type=latestbooks&authid=$authId"),
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

      final dynamicLatest = body['latestBookList'] as List<dynamic>;
      return dynamicLatest
          .map(
            (latest) => LatestEntityModel.fromJson(
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
