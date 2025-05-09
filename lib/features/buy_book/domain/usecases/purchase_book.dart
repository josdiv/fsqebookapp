import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/buy_book/domain/repository/buy_book_repository.dart';

class PurchaseBook implements UsecaseWithParams<void, DataMap> {
  const PurchaseBook(this._repository);

  final BuyBookRepository _repository;

  @override
  ResultFuture<void> call(DataMap params) async =>
      _repository.purchaseBook(params);
}
