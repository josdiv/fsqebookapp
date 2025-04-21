import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/status/domain/repository/status_repository.dart';

class GetUserLoginStatus implements UsecaseWithoutParams<bool> {
  const GetUserLoginStatus(this._repository);

  final StatusRepository _repository;

  @override
  ResultFuture<bool> call() async => _repository.getUserLoginStatus();
}
