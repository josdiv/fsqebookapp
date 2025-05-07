import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/entity/book_url_entity.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/repository/book_details_repository.dart';

class ReadBook implements UsecaseWithParams<BookUrlEntity, DataMap> {
  const ReadBook(this._repository);

  final BookDetailsRepository _repository;

  @override
  ResultFuture<BookUrlEntity> call(DataMap params) async =>
      _repository.readBook(params);
}
