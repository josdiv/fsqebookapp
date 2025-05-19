import 'package:dartz/dartz.dart';
import 'package:foursquare_ebbok_app/core/failure/exceptions.dart';
import 'package:foursquare_ebbok_app/core/failure/failure.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/settings/data/datasource/settings_remote_datasource.dart';
import 'package:foursquare_ebbok_app/features/settings/domain/repository/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._remoteDatasource);

  final SettingsRemoteDatasource _remoteDatasource;

  @override
  ResultFuture<String> getAboutUs() async {
    try {
      final result = await _remoteDatasource.getAboutUs();
      return Right(result);
    } on APIException catch (e) {
      return Left(
        APIFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<String> getTermsOfUse() async {
    try {
      final result = await _remoteDatasource.getTermsOfUse();
      return Right(result);
    } on APIException catch (e) {
      return Left(
        APIFailure.fromException(e),
      );
    }
  }

  @override
  ResultVoid requestAccountDeletion(DataMap data) async {
    try {
      await _remoteDatasource.requestAccountDeletion(data);
      return const Right(null);
    } on APIException catch (e) {
      return Left(
        APIFailure.fromException(e),
      );
    }
  }
}
