import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/sign_up/domain/entity/user_entity.dart';
import 'package:foursquare_ebbok_app/features/sign_up/domain/repository/sign_up_repository.dart';

class UserSignUp implements UsecaseWithParams<UserEntity, DataMap> {
  const UserSignUp(this._repository);

  final SignUpRepository _repository;

  @override
  ResultFuture<UserEntity> call(DataMap params) async =>
      _repository.userSignUp(params);
}
