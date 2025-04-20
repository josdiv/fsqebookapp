import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/login/domain/repository/login_repository.dart';
import 'package:foursquare_ebbok_app/features/sign_up/domain/entity/user_entity.dart';

class SignInWithGoogle implements UsecaseWithParams<UserEntity, DataMap> {
  const SignInWithGoogle(this._repository);

  final LoginRepository _repository;

  @override
  ResultFuture<UserEntity> call(DataMap params) async =>
      _repository.singInWithGoogle(params);
}
