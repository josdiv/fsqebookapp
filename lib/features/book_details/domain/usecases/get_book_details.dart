import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/entity/book_details_entity.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/repository/book_details_repository.dart';

class GetBookDetails implements UsecaseWithParams<BookDetailsEntity, DataMap> {
  const GetBookDetails(this._repository);

  final BookDetailsRepository _repository;

  @override
  ResultFuture<BookDetailsEntity> call(DataMap params) async =>
      _repository.getBookDetails(params);
}
