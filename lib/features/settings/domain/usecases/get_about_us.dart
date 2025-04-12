import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/settings/domain/repository/settings_repository.dart';

class GetAboutUs implements UsecaseWithoutParams<String> {
  const GetAboutUs(this._repository);

  final SettingsRepository _repository;

  @override
  ResultFuture<String> call() async => _repository.getAboutUs();
}
