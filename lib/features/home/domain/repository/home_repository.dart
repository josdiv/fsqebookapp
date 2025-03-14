import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/home/domain/entity/home_entity.dart';

abstract interface class HomeRepository {
  ResultFuture<HomeEntity> getDashboardData();
}
