import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/latest/domain/entity/latest_entity.dart';
import 'package:foursquare_ebbok_app/features/latest/domain/repository/latest_repository.dart';

class GetLatestBooks implements UsecaseWithoutParams<List<LatestEntity>> {
  const GetLatestBooks(this._repository);

  final LatestRepository _repository;

  @override
  ResultFuture<List<LatestEntity>> call() async => _repository.getLatestBooks();
}
