import 'package:dartz/dartz.dart';
import 'package:foursquare_ebbok_app/core/failure/exceptions.dart';
import 'package:foursquare_ebbok_app/core/failure/failure.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/payment_keys/data/datasource/payment_keys_remote_datasource.dart';
import 'package:foursquare_ebbok_app/features/payment_keys/domain/entity/payment_keys_entity.dart';
import 'package:foursquare_ebbok_app/features/payment_keys/domain/repository/payment_keys_repository.dart';

class PaymentKeysRepositoryImpl implements PaymentKeysRepository {
  const PaymentKeysRepositoryImpl(this._remoteDatasource);

  final PaymentKeysRemoteDatasource _remoteDatasource;

  @override
  ResultFuture<PaymentKeysEntity> getPaymentKeys() async {
    try {
      final result = await _remoteDatasource.getPaymentKeys();
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
