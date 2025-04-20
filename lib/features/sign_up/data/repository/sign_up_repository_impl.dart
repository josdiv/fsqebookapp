import 'package:dartz/dartz.dart';
import 'package:foursquare_ebbok_app/core/failure/exceptions.dart';
import 'package:foursquare_ebbok_app/core/failure/failure.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/sign_up/data/datasource/sign_up_remote_datasource.dart';
import 'package:foursquare_ebbok_app/features/sign_up/domain/entity/user_entity.dart';
import 'package:foursquare_ebbok_app/features/sign_up/domain/repository/sign_up_repository.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  const SignUpRepositoryImpl(this._remoteDatasource);

  final SignUpRemoteDatasource _remoteDatasource;

  @override
  ResultFuture<UserEntity> userSignUp(DataMap data) async {
    try {
      final result = await _remoteDatasource.userSignUp(data);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
