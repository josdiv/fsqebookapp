import 'dart:convert';

import 'package:foursquare_ebbok_app/core/constants/constants.dart';
import 'package:foursquare_ebbok_app/core/failure/exceptions.dart';
import 'package:foursquare_ebbok_app/features/book_details/data/models/book_details_entity_model.dart';
import 'package:foursquare_ebbok_app/features/book_details/data/models/book_url_entity_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/typedefs/typedefs.dart';

abstract interface class BookDetailsRemoteDatasource {
  Future<BookDetailsEntityModel> getBookDetails(DataMap data);

  Future<void> reportBook(DataMap data);

  Future<String> toggleFavourite(DataMap data);

  Future<BookUrlEntityModel> readBook(DataMap data);

  Future<BookUrlEntityModel> downloadBook(DataMap data);

  Future<void> writeReview(DataMap data);
}

const String kBookDetails = '/bookdetail.php';
const String kReadBook = '/readbook.php?type=readbook&authid=$authId';
const String kReportBook = '/report.php?type=report&authid=$authId';
const String kToggleFavourite =
    '/addfavorite.php?type=addfavorite&authid=$authId';
const String kDownloadBook =
    '/downloadbook.php?type=downloadbook&authid=$authId';
const String kWriteReview = '/addrating.php?type=addrating&authid=$authId';

class BookDetailsRemoteDatasourceImpl implements BookDetailsRemoteDatasource {
  const BookDetailsRemoteDatasourceImpl(this._client);

  final http.Client _client;

  @override
  Future<BookDetailsEntityModel> getBookDetails(DataMap data) async {
    try {
      final id = data['id'] as String;
      final userId = data['userId'] as String;

      final response = await _client.post(
        Uri.parse(
          "$kBaseUrl$kBookDetails?type=bookdetail&authid=$authId&bookId=$id&userId=$userId",
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

  @override
  Future<BookUrlEntityModel> downloadBook(DataMap data) async {
    try {
      final userId = data['userId'] as String;
      final bookId = data['bookId'] as String;

      final response = await _client.post(
        Uri.parse(
          "$kBaseUrl$kDownloadBook&userId=$userId&bookId=$bookId",
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

      return BookUrlEntityModel.fromMap(body);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 515,
      );
    }
  }

  @override
  Future<BookUrlEntityModel> readBook(DataMap data) async {
    try {
      final userId = data['userId'] as String;
      final bookId = data['bookId'] as String;

      final response = await _client.post(
        Uri.parse(
          "$kBaseUrl$kReadBook&userId=$userId&bookId=$bookId",
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

      return BookUrlEntityModel.fromMap(body);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 515,
      );
    }
  }

  @override
  Future<void> reportBook(DataMap data) async {
    try {
      final userId = data['userId'] as String;
      final reasons = data['reasons'] as String;

      final response = await _client.post(
        Uri.parse(
          "$kBaseUrl$kReportBook&userId=$userId&reasons=$reasons",
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
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 515,
      );
    }
  }

  @override
  Future<String> toggleFavourite(DataMap data) async {
    try {
      final userId = data['userId'] as String;
      final bookId = data['bookId'] as String;

      final response = await _client.post(
        Uri.parse(
          "$kBaseUrl$kToggleFavourite&userId=$userId&bookId=$bookId",
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

      return body['message'] as String;
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 515,
      );
    }
  }

  @override
  Future<void> writeReview(DataMap data) async {
    try {
      final userId = data['userId'] as String;
      final bookId = data['bookId'] as String;
      final reviews = data['reviews'] as String;
      final bookRating = data['bookRating'] as String;

      final response = await _client.post(
        Uri.parse(
          "$kBaseUrl$kWriteReview&userId=$userId&bookId=$bookId&reviews=$reviews&bookRating=$bookRating",
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
