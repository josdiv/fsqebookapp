import 'dart:convert';

import 'package:foursquare_ebbok_app/core/constants/constants.dart';
import 'package:foursquare_ebbok_app/features/profile/data/model/profile_entity_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/failure/exceptions.dart';
import '../../../../core/utils/typedefs/typedefs.dart';

abstract interface class ProfileRemoteDatasource {
  Future<ProfileEntityModel> getUserProfile(String email);

  Future<void> editUserProfile(DataMap data);
}

const String kGetProfile = "/profile.php?type=profile&authid=$authId";
const String kEditProfile = "/editprofile.php?type=editprofile&authid=$authId";

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  const ProfileRemoteDatasourceImpl(this._client);

  final http.Client _client;

  @override
  Future<void> editUserProfile(DataMap data) async {
    try {
      final name = data['name'] as String;
      final email = data['email'] as String;
      final password = data['password'] ?? '';
      final phone = data['phone'] ?? '';
      final userimage = data['userimage'];

      print("userImage: $userimage");

      final response = await _client
          .post(
            Uri.parse("$kBaseUrl$kEditProfile&name=$name&email=$email&password="
                "$password&phone=$phone&userimage=$userimage"),
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
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 515,
      );
    }
  }

  @override
  Future<ProfileEntityModel> getUserProfile(String email) async {
    try {
      final response = await _client
          .post(Uri.parse("$kBaseUrl$kGetProfile&email=$email"))
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

      return ProfileEntityModel.fromMap(body);
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
