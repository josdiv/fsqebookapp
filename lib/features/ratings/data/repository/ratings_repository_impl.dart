import 'package:dartz/dartz.dart';
import 'package:foursquare_ebbok_app/core/failure/exceptions.dart';
import 'package:foursquare_ebbok_app/core/failure/failure.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/ratings/data/datasource/ratings_remote_datasource.dart';
import 'package:foursquare_ebbok_app/features/ratings/domain/entity/rating_entity.dart';
import 'package:foursquare_ebbok_app/features/ratings/domain/repository/ratings_repository.dart';

class RatingsRepositoryImpl implements RatingsRepository {
  const RatingsRepositoryImpl(this._remoteDatasource);

  final RatingsRemoteDatasource _remoteDatasource;

  @override
  ResultFuture<List<RatingEntity>> getBookRatings(String id) async {
    try {
      final result = await _remoteDatasource.getBookRatings(id);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
