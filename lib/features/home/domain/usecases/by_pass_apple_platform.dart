import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/home/domain/entity/home_entity.dart';
import 'package:foursquare_ebbok_app/features/home/domain/repository/home_repository.dart';

class ByPassApplePlatform implements UsecaseWithoutParams<ByPassEntity> {
  const ByPassApplePlatform(this._repository);

  final HomeRepository _repository;

  @override
  ResultFuture<ByPassEntity> call() async => _repository.byPassApplePlatform();
}
