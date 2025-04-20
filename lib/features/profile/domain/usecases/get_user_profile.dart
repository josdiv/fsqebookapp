import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/profile/domain/entity/profile_entity.dart';
import 'package:foursquare_ebbok_app/features/profile/domain/repository/profile_repository.dart';

class GetUserProfile implements UsecaseWithParams<ProfileEntity, String> {
  const GetUserProfile(this._repository);

  final ProfileRepository _repository;

  @override
  ResultFuture<ProfileEntity> call(String params) async =>
      _repository.getUserProfile(params);
}
