import 'dart:convert';

import 'package:foursquare_ebbok_app/core/constants/constants.dart';
import 'package:http/http.dart' as http;
import '../../../../core/failure/exceptions.dart';
import '../../../../core/utils/typedefs/typedefs.dart';
import '../models/payment_keys_entity_model.dart';

abstract interface class PaymentKeysRemoteDatasource {
  Future<PaymentKeysEntityModel> getPaymentKeys();
}

const kPaymentKeys = "/paymentkeys.php?type=paymentkeys&authid=$authId";

class PaymentKeysRemoteDatasourceImpl implements PaymentKeysRemoteDatasource {
  const PaymentKeysRemoteDatasourceImpl(this._client);

  final http.Client _client;

  @override
  Future<PaymentKeysEntityModel> getPaymentKeys() async {
    try {
      final response = await _client.post(
        Uri.parse("$kBaseUrl$kPaymentKeys"),
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

      return PaymentKeysEntityModel.fromMap(body);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 515);
    }
  }
}
