import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/sign_up/domain/entity/user_entity.dart';

abstract interface class SignUpRepository {
  ResultFuture<UserEntity> userSignUp(DataMap data);
}
