import 'dart:convert';

import 'package:foursquare_ebbok_app/core/constants/constants.dart';
import 'package:foursquare_ebbok_app/features/sign_up/data/model/user_entity_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/failure/exceptions.dart';
import '../../../../core/utils/typedefs/typedefs.dart';

abstract interface class LoginRemoteDatasource {
  Future<UserEntityModel> singInWithPassword(DataMap data);

  Future<UserEntityModel> singInWithGoogle(DataMap data);
}

const String kSignInWithPassword = '/signin.php?type=signin&authid=$authId';
const String kSignInWithGoogle =
    '/googlesignin.php?type=googlesignin&authid=$authId';

class LoginRemoteDatasourceImpl implements LoginRemoteDatasource {
  const LoginRemoteDatasourceImpl(this._client);

  final http.Client _client;

  @override
  Future<UserEntityModel> singInWithGoogle(DataMap data) async {
    try {
      final googleId = data['googleId'] as String;
      final googleName = data['googleName'] as String;
      final googleEmail = data['googleEmail'] as String;

      final response = await _client
          .post(
            Uri.parse(
                "$kBaseUrl$kSignInWithGoogle&googleId=$googleId&googleName="
                "$googleName&googleEmail=$googleEmail"),
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

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('email', googleEmail);

      return UserEntityModel.fromJson(body);
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
  Future<UserEntityModel> singInWithPassword(DataMap data) async {
    try {
      final email = data['email'] as String;
      final password = data['password'] as String;

      final response = await _client
          .post(
            Uri.parse(
                "$kBaseUrl$kSignInWithPassword&email=$email&password=$password"),
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

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);

      return UserEntityModel.fromJson(body);
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
