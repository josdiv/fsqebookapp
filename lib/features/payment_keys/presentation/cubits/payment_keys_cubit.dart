
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/features/payment_keys/domain/entity/payment_keys_entity.dart';
import 'package:foursquare_ebbok_app/features/payment_keys/domain/usecases/get_payment_keys.dart';

part 'payment_keys_state.dart';

class PaymentKeysCubit extends Cubit<PaymentKeysState> {
  PaymentKeysCubit({
    required GetPaymentKeys getPaymentKeys,
  })  : _getPaymentKeys = getPaymentKeys,
        super(PaymentKeysInitial());

  final GetPaymentKeys _getPaymentKeys;

  Future<void> getPaymentKeysEvent() async {
    emit(GetPaymentKeysLoadingState());

    final result = await _getPaymentKeys();

    result.fold(
      (l) => emit(
        GetPaymentKeysErrorState(l.errorMessage),
      ),
      (r) => emit(
        GetPaymentKeysSuccessState(r),
      ),
    );
  }
}
