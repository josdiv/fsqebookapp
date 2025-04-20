import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/ratings/domain/repository/ratings_repository.dart';

import '../entity/rating_entity.dart';

class GetBookRatings implements UsecaseWithParams<List<RatingEntity>, String> {
  const GetBookRatings(this._repository);

  final RatingsRepository _repository;

  @override
  ResultFuture<List<RatingEntity>> call(String params) async =>
      _repository.getBookRatings(params);
}
