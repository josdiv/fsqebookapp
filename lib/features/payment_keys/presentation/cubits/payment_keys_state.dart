part of 'payment_keys_cubit.dart';

sealed class PaymentKeysState extends Equatable {
  const PaymentKeysState();

  @override
  List<Object> get props => [];
}

final class PaymentKeysInitial extends PaymentKeysState {}

final class GetPaymentKeysLoadingState extends PaymentKeysState {}

final class GetPaymentKeysErrorState extends PaymentKeysState {
  const GetPaymentKeysErrorState(this.error);

  final String error;
  @override
  List<Object> get props => [error];
}

final class GetPaymentKeysSuccessState extends PaymentKeysState {
  const GetPaymentKeysSuccessState(this.keys);

  final PaymentKeysEntity keys;

  @override
  List<Object> get props => [keys];
}