import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/profile/domain/entity/profile_entity.dart';

abstract interface class ProfileRepository {
  ResultFuture<ProfileEntity> getUserProfile(String email);

  ResultVoid editUserProfile(DataMap data);
}
