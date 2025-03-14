import 'dart:async';
import 'dart:convert';

import 'package:foursquare_ebbok_app/core/constants/constants.dart';
import 'package:foursquare_ebbok_app/core/failure/exceptions.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';

import '../model/home_entity_model.dart';
import 'package:http/http.dart' as http;

abstract interface class HomeRemoteDatasource {
  Future<HomeEntityModel> getDashboardData();
}

const String kHomeDataEndpoint = '/homescreen.php';

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  const HomeRemoteDatasourceImpl(this._client);

  final http.Client _client;

  @override
  Future<HomeEntityModel> getDashboardData() async {
    try {
      final response = await _client.post(
        Uri.parse("$kBaseUrl$kHomeDataEndpoint?type=dashboard&authid=$authId"),
      ).timeout(Duration(seconds: 15));

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

      return HomeEntityModel.fromJson(body);

    } on APIException {
      rethrow;
    } on TimeoutException {
      throw ServerException(message: timeoutMessage, statusCode: 409);
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 515,
      );
    }
  }
}
