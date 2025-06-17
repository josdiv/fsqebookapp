import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/payment_keys/domain/entity/payment_keys_entity.dart';
import 'package:foursquare_ebbok_app/features/payment_keys/domain/repository/payment_keys_repository.dart';

class GetPaymentKeys implements UsecaseWithoutParams<PaymentKeysEntity> {
  const GetPaymentKeys(this._repository);

  final PaymentKeysRepository _repository;

  @override
  ResultFuture<PaymentKeysEntity> call() async => _repository.getPaymentKeys();
}
