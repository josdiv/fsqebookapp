import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/payment_keys/domain/entity/payment_keys_entity.dart';

abstract class PaymentKeysRepository {
  ResultFuture<PaymentKeysEntity> getPaymentKeys();
}
