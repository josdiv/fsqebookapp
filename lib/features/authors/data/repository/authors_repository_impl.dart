import 'package:dartz/dartz.dart';
import 'package:foursquare_ebbok_app/core/failure/exceptions.dart';
import 'package:foursquare_ebbok_app/core/failure/failure.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/authors/data/datasource/authors_remote_datasource.dart';
import 'package:foursquare_ebbok_app/features/authors/domain/entity/author_entity.dart';
import 'package:foursquare_ebbok_app/features/authors/domain/repository/authors_repository.dart';

class AuthorsRepositoryImpl implements AuthorsRepository {
  const AuthorsRepositoryImpl(this._remoteDatasource);

  final AuthorsRemoteDatasource _remoteDatasource;

  @override
  ResultFuture<List<AuthorEntity>> getAuthors() async {
    try {
      final result = await _remoteDatasource.getAuthors();
      return Right(result);
    } on APIException catch(e) {
      return Left(APIFailure.fromException(e));
    }
  }
}