import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/authors/domain/entity/author_entity.dart';
import 'package:foursquare_ebbok_app/features/authors/domain/repository/authors_repository.dart';

class GetAuthors implements UsecaseWithoutParams<List<AuthorEntity>> {
  const GetAuthors(this._repository);

  final AuthorsRepository _repository;

  @override
  ResultFuture<List<AuthorEntity>> call() async => _repository.getAuthors();
}
