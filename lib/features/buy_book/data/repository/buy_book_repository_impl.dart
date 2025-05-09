import 'package:dartz/dartz.dart';
import 'package:foursquare_ebbok_app/core/failure/exceptions.dart';
import 'package:foursquare_ebbok_app/core/failure/failure.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/buy_book/data/datasource/buy_book_remote_datasource.dart';
import 'package:foursquare_ebbok_app/features/buy_book/domain/repository/buy_book_repository.dart';

class BuyBookRepositoryImpl implements BuyBookRepository {
  const BuyBookRepositoryImpl(this._remoteDatasource);

  final BuyBookRemoteDatasource _remoteDatasource;

  @override
  ResultVoid purchaseBook(DataMap data) async {
    try {
      final result = await _remoteDatasource.purchaseBook(data);
      return Right(result);
    } on APIException catch (e) {
      return Left(
        APIFailure.fromException(e),
      );
    }
  }
}
