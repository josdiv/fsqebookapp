import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/home/domain/entity/home_entity.dart';
import 'package:foursquare_ebbok_app/features/home/domain/entity/searched_entity.dart';

abstract interface class HomeRepository {
  ResultFuture<HomeEntity> getDashboardData();

  ResultFuture<List<SearchedEntity>> getSearchedBooks(String params);

  ResultVoid deleteAccount(DataMap data);

  ResultFuture<ByPassEntity> byPassApplePlatform();
}
