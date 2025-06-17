import 'package:equatable/equatable.dart';

class PaymentKeysEntity extends Equatable {
  const PaymentKeysEntity({
    required this.paystackPublicKey,
    required this.paystackSecretKey,
    required this.flutterwavePublicKey,
    required this.flutterwaveSecretKey,
  });

  const PaymentKeysEntity.initial()
      : this(
          paystackPublicKey: '',
          paystackSecretKey: '',
          flutterwavePublicKey: '',
          flutterwaveSecretKey: '',
        );

  final String paystackPublicKey;
  final String paystackSecretKey;
  final String flutterwavePublicKey;
  final String flutterwaveSecretKey;

  @override
  List<Object?> get props => [
        paystackPublicKey,
        paystackSecretKey,
        flutterwavePublicKey,
        flutterwaveSecretKey,
      ];
}
