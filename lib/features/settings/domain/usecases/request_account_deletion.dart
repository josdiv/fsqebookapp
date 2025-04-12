import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/settings/domain/repository/settings_repository.dart';

class RequestAccountDeletion implements UsecaseWithParams<void, DataMap> {
  const RequestAccountDeletion(this._repository);

  final SettingsRepository _repository;

  @override
  ResultFuture<void> call(DataMap params) async =>
      _repository.requestAccountDeletion(params);
}
