import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/home/domain/entity/home_entity.dart';
import 'package:foursquare_ebbok_app/features/home/domain/repository/home_repository.dart';

class GetDashboardData implements UsecaseWithoutParams<HomeEntity> {
  const GetDashboardData(this._repository);

  final HomeRepository _repository;

  @override
  ResultFuture<HomeEntity> call() async => _repository.getDashboardData();
}
