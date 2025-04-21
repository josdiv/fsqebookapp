import 'package:dartz/dartz.dart';
import 'package:foursquare_ebbok_app/core/failure/exceptions.dart';
import 'package:foursquare_ebbok_app/core/failure/failure.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/status/data/datasource/status_local_datasource.dart';
import 'package:foursquare_ebbok_app/features/status/domain/repository/status_repository.dart';

class StatusRepositoryImpl implements StatusRepository {
  const StatusRepositoryImpl(this._localDatasource);

  final StatusLocalDatasource _localDatasource;

  @override
  ResultFuture<bool> getUserLoginStatus() async {
    try {
      final result = await _localDatasource.getUserLoginStatus();
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid setUserLoginStatus(bool status) async {
    try {
      await _localDatasource.setUserLoginStatus(status);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
