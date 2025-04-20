import 'dart:convert';

import 'package:foursquare_ebbok_app/core/constants/constants.dart';
import 'package:foursquare_ebbok_app/core/failure/exceptions.dart';
import 'package:foursquare_ebbok_app/features/sign_up/data/model/user_entity_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/typedefs/typedefs.dart';

abstract interface class SignUpRemoteDatasource {
  Future<UserEntityModel> userSignUp(DataMap data);
}

const String kSignUp = "/signup.php?type=signup&authid=$authId";

class SignUpRemoteDatasourceImpl implements SignUpRemoteDatasource {
  const SignUpRemoteDatasourceImpl(this._client);

  final http.Client _client;

  @override
  Future<UserEntityModel> userSignUp(DataMap data) async {
    try {
      final name = data['name'] as String;
      final email = data['email'] as String;
      final password = data['password'] as String;
      final phone = data['phone'] as String;

      final response = await _client
          .post(
            Uri.parse("$kBaseUrl$kSignUp&name=$name&email=$email&password="
                "$password&phone=$phone"),
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

      return UserEntityModel.fromJson(body['userDetail'] as DataMap);
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
