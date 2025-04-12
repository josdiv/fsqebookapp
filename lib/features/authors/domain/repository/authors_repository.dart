import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/authors/domain/entity/author_details_entity.dart';
import 'package:foursquare_ebbok_app/features/authors/domain/entity/author_entity.dart';

abstract interface class AuthorsRepository {
  ResultFuture<List<AuthorEntity>> getAuthors();

  ResultFuture<AuthorDetailsEntity> getSingleAuthor(String id);
}
