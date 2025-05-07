import 'package:dartz/dartz.dart';
import 'package:foursquare_ebbok_app/core/failure/exceptions.dart';
import 'package:foursquare_ebbok_app/core/failure/failure.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/book_details/data/datasource/book_details_remote_datasource.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/entity/book_details_entity.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/entity/book_url_entity.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/repository/book_details_repository.dart';

class BookDetailsRepositoryImpl implements BookDetailsRepository {
  const BookDetailsRepositoryImpl(this._remoteDatasource);

  final BookDetailsRemoteDatasource _remoteDatasource;

  @override
  ResultFuture<BookDetailsEntity> getBookDetails(String id) async {
    try {
      final result = await _remoteDatasource.getBookDetails(id);
      return Right(result);
    } on APIException catch (e) {
      return Left(
        APIFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<BookUrlEntity> downloadBook(DataMap data) async {
    try {
      final result = await _remoteDatasource.downloadBook(data);
      return Right(result);
    } on APIException catch (e) {
      return Left(
        APIFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<BookUrlEntity> readBook(DataMap data) async {
    try {
      final result = await _remoteDatasource.readBook(data);
      return Right(result);
    } on APIException catch (e) {
      return Left(
        APIFailure.fromException(e),
      );
    }
  }

  @override
  ResultVoid reportBook(DataMap data) async {
    try {
      await _remoteDatasource.reportBook(data);
      return const Right(null);
    } on APIException catch (e) {
      return Left(
        APIFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<String> toggleFavourite(DataMap data) async {
    try {
      final result = await _remoteDatasource.toggleFavourite(data);
      return Right(result);
    } on APIException catch (e) {
      return Left(
        APIFailure.fromException(e),
      );
    }
  }

  @override
  ResultVoid writeReview(DataMap data) async {
    try {
      await _remoteDatasource.writeReview(data);
      return const Right(null);
    } on APIException catch (e) {
      return Left(
        APIFailure.fromException(e),
      );
    }
  }
}
