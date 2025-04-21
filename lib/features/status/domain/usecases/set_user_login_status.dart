import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/status/domain/repository/status_repository.dart';

class SetUserLoginStatus implements UsecaseWithParams<void, bool> {
  const SetUserLoginStatus(this._repository);

  final StatusRepository _repository;

  @override
  ResultFuture<void> call(bool params) async =>
      _repository.setUserLoginStatus(params);
}
