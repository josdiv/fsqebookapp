import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/profile/domain/repository/profile_repository.dart';

class EditUserProfile implements UsecaseWithParams<void, DataMap> {
  const EditUserProfile(this._repository);

  final ProfileRepository _repository;

  @override
  ResultFuture<void> call(DataMap params) async =>
      _repository.editUserProfile(params);
}
