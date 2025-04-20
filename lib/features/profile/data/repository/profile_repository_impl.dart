import 'package:dartz/dartz.dart';
import 'package:foursquare_ebbok_app/core/failure/exceptions.dart';
import 'package:foursquare_ebbok_app/core/failure/failure.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:foursquare_ebbok_app/features/profile/domain/entity/profile_entity.dart';
import 'package:foursquare_ebbok_app/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._remoteDatasource);

  final ProfileRemoteDatasource _remoteDatasource;

  @override
  ResultVoid editUserProfile(DataMap data) async {
    try {
      final result = await _remoteDatasource.editUserProfile(data);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<ProfileEntity> getUserProfile(String email) async {
    try {
      final result = await _remoteDatasource.getUserProfile(email);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
