import 'dart:convert';

import 'package:foursquare_ebbok_app/core/constants/constants.dart';
import 'package:http/http.dart' as http;
import '../../../../core/failure/exceptions.dart';
import '../../../../core/utils/typedefs/typedefs.dart';

abstract interface class BuyBookRemoteDatasource {
  Future<void> purchaseBook(DataMap data);
}

const kPurchaseBook = '/payment.php?type=payment&authid=$authId';

class BuyBookRemoteDatasourceImpl implements BuyBookRemoteDatasource {
  const BuyBookRemoteDatasourceImpl(this._client);

  final http.Client _client;

  @override
  Future<void> purchaseBook(DataMap data) async {
    try {
      final bookId = data['bookId'] as String;
      final userId = data['userId'] as String;
      final paymentId = data['paymentId'] as String;
      final gateway = data['gateway'] as String;

      final response = await _client.post(
        Uri.parse(
          "$kBaseUrl$kPurchaseBook&bookId=$bookId&userId=$userId&paymentId=$paymentId&gateway=$gateway",
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
