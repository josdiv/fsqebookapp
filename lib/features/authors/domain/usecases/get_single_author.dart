import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/authors/domain/entity/author_details_entity.dart';
import 'package:foursquare_ebbok_app/features/authors/domain/repository/authors_repository.dart';

class GetSingleAuthor
    implements UsecaseWithParams<AuthorDetailsEntity, String> {
  const GetSingleAuthor(this._repository);

  final AuthorsRepository _repository;

  @override
  ResultFuture<AuthorDetailsEntity> call(String params) async =>
      _repository.getSingleAuthor(params);
}
