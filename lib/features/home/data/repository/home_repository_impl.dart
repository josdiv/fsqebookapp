import 'package:dartz/dartz.dart';
import 'package:foursquare_ebbok_app/core/failure/exceptions.dart';
import 'package:foursquare_ebbok_app/core/failure/failure.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/home/data/datasource/home_remote_datasource.dart';
import 'package:foursquare_ebbok_app/features/home/domain/entity/home_entity.dart';
import 'package:foursquare_ebbok_app/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._remoteDatasource);

  final HomeRemoteDatasource _remoteDatasource;

  @override
  ResultFuture<HomeEntity> getDashboardData() async {
    try {
      final result = await _remoteDatasource.getDashboardData();
      return Right(result);
    } on APIException catch (e) {
      return Left(
        APIFailure.fromException(e),
      );
    }
  }
}
