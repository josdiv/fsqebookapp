import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/sign_up/domain/entity/user_entity.dart';

abstract interface class LoginRepository {
  ResultFuture<UserEntity> singInWithPassword(DataMap data);

  ResultFuture<UserEntity> singInWithGoogle(DataMap data);
}