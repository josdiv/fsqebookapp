import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/home/domain/entity/searched_entity.dart';
import 'package:foursquare_ebbok_app/features/home/domain/repository/home_repository.dart';

class GetSearchedBooks
    implements UsecaseWithParams<List<SearchedEntity>, String> {
  const GetSearchedBooks(this._repository);

  final HomeRepository _repository;

  @override
  ResultFuture<List<SearchedEntity>> call(String params) async =>
      _repository.getSearchedBooks(params);
}
