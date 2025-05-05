import 'dart:convert';
import 'package:html/parser.dart' as html_parser;
import 'package:foursquare_ebbok_app/core/constants/constants.dart';
import 'package:foursquare_ebbok_app/core/failure/exceptions.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/typedefs/typedefs.dart';

abstract interface class SettingsRemoteDatasource {
  Future<String> getAboutUs();

  Future<String> getTermsOfUse();

  Future<void> requestAccountDeletion(DataMap data);
}

const String kAboutUs = "/about.php?type=about";
const String kTermsOfUse = "/terms.php?type=terms";
const kDeleteAccount = "/deleteaccount.php?type=deleteaccount&authid=$authId";

class SettingsRemoteDatasourceImpl implements SettingsRemoteDatasource {
  const SettingsRemoteDatasourceImpl(this._client);

  final http.Client _client;

  @override
  Future<String> getAboutUs() async {
    try {
      final response = await _client.get(
        Uri.parse("$kBaseUrl$kAboutUs&authid=$authId"),
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

      final termsContent = body['aboutContent'] as String;
      final document = html_parser.parse(termsContent);

      return document.body?.text ?? "No content found";
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
  Future<String> getTermsOfUse() async {
    try {
      final response = await _client.get(
        Uri.parse("$kBaseUrl$kTermsOfUse&authid=$authId"),
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

      final termsContent = body['termsContent'] as String;
      final document = html_parser.parse(termsContent);

      return document.body?.text ?? "No content found";
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
  Future<void> requestAccountDeletion(DataMap data) async {
    try {
      final email = data['email'] as String;
      final reason = data['reason'] as String;

      final response = await _client.get(
        Uri.parse(
          "$kBaseUrl$kDeleteAccount&authid=$authId&email=$email&reason=$reason",
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
