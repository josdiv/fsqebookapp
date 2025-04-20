import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';

import '../entity/rating_entity.dart';

abstract interface class RatingsRepository {
  ResultFuture<List<RatingEntity>> getBookRatings(String id);
}
