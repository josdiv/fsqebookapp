import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:foursquare_ebbok_app/core/constants/constants.dart';
import 'package:foursquare_ebbok_app/core/failure/exceptions.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/home/data/model/searched_entity_model.dart';
import 'package:http/http.dart' as http;

import '../model/home_entity_model.dart';

abstract interface class HomeRemoteDatasource {
  Future<HomeEntityModel> getDashboardData();

  Future<List<SearchedEntityModel>> getSearchedBooks(String params);

  Future<void> deleteAccount(DataMap data);

  Future<ByPassEntityModel> byPassApplePlatform();
}

const String kHomeDataEndpoint = '/homescreen.php';
const kSearchedEndpoint = '/searchresult.php?type=searchresult&authid=$authId';
const kDeleteAccount = "/deleteaccount.php?type=deleteaccount&authid=$authId";
const kByPass = '/appleplatform.php?type=appleplatform&authid=$authId';

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  const HomeRemoteDatasourceImpl(this._client);

  final http.Client _client;

  @override
  Future<HomeEntityModel> getDashboardData() async {
    try {
      final response = await _client
          .post(
            Uri.parse(
                "$kBaseUrl$kHomeDataEndpoint?type=dashboard&authid=$authId"),
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
      debugPrint('Response body: $body');

      final status = body['status'] as String;

      if (status.toLowerCase() == 'failed' || status.toLowerCase() == 'error') {
        final message = body['message'] as String;
        throw APIException(
          message: message,
          statusCode: response.statusCode,
        );
      }

      return HomeEntityModel.fromJson(body);
    } on APIException {
      rethrow;
    } on TimeoutException {
      throw APIException(message: timeoutMessage, statusCode: 409);
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 515,
      );
    }
  }

  @override
  Future<List<SearchedEntityModel>> getSearchedBooks(String params) async {
    try {
      final response = await _client
          .post(
            Uri.parse(
              "$kBaseUrl$kSearchedEndpoint?type=dashboard&authid=$authId&searchParam=$params",
            ),
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
        throw APIException(
          message: message,
          statusCode: response.statusCode,
        );
      }

      final dynamicBooks = body['listBooks'] as List<dynamic>;

      return dynamicBooks
          .map(
            (e) => SearchedEntityModel.fromJson(e as DataMap),
          )
          .toList();
    } on APIException {
      rethrow;
    } on TimeoutException {
      throw APIException(message: timeoutMessage, statusCode: 409);
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 515,
      );
    }
  }

  @override
  Future<void> deleteAccount(DataMap data) async {
    try {
      final email = data['email'] as String;
      final reason = data['reason'] as String;

      final response = await _client
          .post(
            Uri.parse(
              "$kBaseUrl$kDeleteAccount&email=$email&reason=$reason",
            ),
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
        throw APIException(
          message: message,
          statusCode: response.statusCode,
        );
      }
    } on APIException {
      rethrow;
    } on TimeoutException {
      throw APIException(
        message: timeoutMessage,
        statusCode: 409,
      );
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 515,
      );
    }
  }

  @override
  Future<ByPassEntityModel> byPassApplePlatform() async {
    debugPrint('Called');
    try {
      final response = await _client
          .post(
            Uri.parse("$kBaseUrl$kByPass"),
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
      debugPrint('Response body: $body');

      final status = body['success'] as String;

      if (status.toLowerCase() == 'failed' || status.toLowerCase() == 'error') {
        final message = body['message'] as String;
        throw APIException(
          message: message,
          statusCode: response.statusCode,
        );
      }

      return ByPassEntityModel.fromMap(body);
    } on APIException {
      rethrow;
    } on TimeoutException {
      throw APIException(message: timeoutMessage, statusCode: 409);
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 515,
      );
    }
  }
}
