
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/features/buy_book/domain/usecases/purchase_book.dart';
import 'package:foursquare_ebbok_app/features/buy_book/presentation/model/buy_book_model.dart';

import '../../../../core/utils/typedefs/typedefs.dart';

part 'buy_book_state.dart';

class BuyBookCubit extends Cubit<BuyBookState> {
  BuyBookCubit({
    required PurchaseBook purchaseBook,
  })  : _purchaseBook = purchaseBook,
        super(BuyBookInitial());

  final PurchaseBook _purchaseBook;

  Future<void> buyBookScreenEvent(BuyBookModel model) async {
    emit(BuyBookScreenState(model));
  }

  Future<void> purchaseBookEvent(DataMap data) async {
    final model = state.model;
    final networkModel = model.networkModel;

    emit(
      BuyBookScreenState(
        model.copyWith(
          networkModel: networkModel.copyWith(
            loading: true,
            error: '',
            loaded: false,
          ),
        ),
      ),
    );

    final result = await _purchaseBook(data);

    result.fold(
      (l) => emit(
        BuyBookScreenState(
          model.copyWith(
            networkModel: networkModel.copyWith(
              loading: false,
              error: l.errorMessage,
              loaded: false,
            ),
          ),
        ),
      ),
      (r) => emit(
        BuyBookScreenState(
          model.copyWith(
            networkModel: networkModel.copyWith(
              loading: false,
              error: '',
              loaded: true,
            ),
          ),
        ),
      ),
    );
  }
}
