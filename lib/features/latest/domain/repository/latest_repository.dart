import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/latest/domain/entity/latest_entity.dart';

abstract interface class LatestRepository {
  ResultFuture<List<LatestEntity>> getLatestBooks();
}
