import 'dart:async';
import 'dart:convert';

import 'package:foursquare_ebbok_app/core/constants/constants.dart';
import 'package:foursquare_ebbok_app/core/failure/exceptions.dart';
import 'package:foursquare_ebbok_app/features/ratings/data/model/rating_entity_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/typedefs/typedefs.dart';

abstract interface class RatingsRemoteDatasource {
  Future<List<RatingEntityModel>> getBookRatings(String id);
}

const String kBookRatings = '/viewrating.php?type=viewrating';

class RatingsRemoteDatasourceImpl implements RatingsRemoteDatasource {
  const RatingsRemoteDatasourceImpl(this._client);

  final http.Client _client;

  @override
  Future<List<RatingEntityModel>> getBookRatings(String id) async {
    try {
      final response = await _client
          .post(
            Uri.parse("$kBaseUrl$kBookRatings&authid=$authId&bookId=$id"),
          )
          .timeout(
            Duration(seconds: 15),
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

      final dynamicRatings = body['ratingList'] as List<dynamic>;

      return dynamicRatings
          .map(
            (e) => RatingEntityModel.fromJson(
              e as DataMap,
            ),
          )
          .toList();
    } on APIException {
      rethrow;
    } on TimeoutException {
      throw ServerException(message: timeoutMessage, statusCode: 409);
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 515);
    }
  }
}
