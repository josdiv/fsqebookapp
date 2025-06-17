import '../../domain/entity/payment_keys_entity.dart';

class PaymentKeysEntityModel extends PaymentKeysEntity {
  const PaymentKeysEntityModel({
    required super.paystackPublicKey,
    required super.paystackSecretKey,
    required super.flutterwavePublicKey,
    required super.flutterwaveSecretKey,
  });

  factory PaymentKeysEntityModel.fromMap(Map<String, dynamic> map) {
    return PaymentKeysEntityModel(
      paystackPublicKey: map['paystackPublicKey'] as String,
      paystackSecretKey: map['paystackSecretKey'] as String,
      flutterwavePublicKey: map['flutterwavePublicKey'] as String,
      flutterwaveSecretKey: map['flutterwaveSecretKey'] as String,
    );
  }
}