import 'dart:convert';

import 'package:foursquare_ebbok_app/core/constants/constants.dart';
import 'package:foursquare_ebbok_app/core/failure/exceptions.dart';
import 'package:foursquare_ebbok_app/features/book_details/data/models/book_details_entity_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/typedefs/typedefs.dart';

abstract interface class BookDetailsRemoteDatasource {
  Future<BookDetailsEntityModel> getBookDetails(String id);
}

const String kBookDetails = '/bookdetail.php';

class BookDetailsRemoteDatasourceImpl implements BookDetailsRemoteDatasource {
  const BookDetailsRemoteDatasourceImpl(this._client);

  final http.Client _client;

  @override
  Future<BookDetailsEntityModel> getBookDetails(String id) async {
    try {
      final response = await _client.post(
        Uri.parse(
          "$kBaseUrl$kBookDetails?type=bookdetail&authid=$authId&bookId=$id",
        ),
      );

      if (response.statusCode != 200) {
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

      return BookDetailsEntityModel.fromJson(body);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 515,
      );
    }
  }
}
