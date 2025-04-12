import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/settings/domain/repository/settings_repository.dart';

class GetTermsOfUse implements UsecaseWithoutParams<String> {
  const GetTermsOfUse(this._repository);

  final SettingsRepository _repository;

  @override
  ResultFuture<String> call() async => _repository.getTermsOfUse();
}
