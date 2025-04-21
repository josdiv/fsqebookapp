import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/home/domain/repository/home_repository.dart';

class DeleteAccount implements UsecaseWithParams<void, DataMap> {
  const DeleteAccount(this._repository);

  final HomeRepository _repository;

  @override
  ResultFuture<void> call(DataMap params) async =>
      _repository.deleteAccount(params);
}
