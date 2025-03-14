import 'package:dartz/dartz.dart';
import 'package:foursquare_ebbok_app/core/failure/exceptions.dart';
import 'package:foursquare_ebbok_app/core/failure/failure.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/latest/data/datasource/latest_remote_datasource.dart';
import 'package:foursquare_ebbok_app/features/latest/domain/entity/latest_entity.dart';
import 'package:foursquare_ebbok_app/features/latest/domain/repository/latest_repository.dart';

class LatestRepositoryImpl implements LatestRepository {
  const LatestRepositoryImpl(this._remoteDatasource);

  final LatestRemoteDatasource _remoteDatasource;

  @override
  ResultFuture<List<LatestEntity>> getLatestBooks() async {
    try {
      final result = await _remoteDatasource.getLatestBooks();
      return Right(result);
    } on APIException catch (e) {
      return Left(
        APIFailure.fromException(e),
      );
    }
  }
}
