import 'package:dartz/dartz.dart';
import 'package:foursquare_ebbok_app/core/failure/exceptions.dart';
import 'package:foursquare_ebbok_app/core/failure/failure.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/login/data/datasource/login_remote_datasource.dart';
import 'package:foursquare_ebbok_app/features/login/domain/repository/login_repository.dart';
import 'package:foursquare_ebbok_app/features/sign_up/domain/entity/user_entity.dart';

class LoginRepositoryImpl implements LoginRepository {
  const LoginRepositoryImpl(this._repository);

  final LoginRemoteDatasource _repository;

  @override
  ResultFuture<UserEntity> singInWithGoogle(DataMap data) async {
    try {
      final result = await _repository.singInWithGoogle(data);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<UserEntity> singInWithPassword(DataMap data) async {
    try {
      final result = await _repository.singInWithPassword(data);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
