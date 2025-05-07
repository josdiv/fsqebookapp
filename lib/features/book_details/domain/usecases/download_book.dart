import 'package:foursquare_ebbok_app/core/usecases/usecase.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/entity/book_url_entity.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/repository/book_details_repository.dart';

class DownloadBook implements UsecaseWithParams<BookUrlEntity, DataMap> {
  const DownloadBook(this._repository);

  final BookDetailsRepository _repository;

  @override
  ResultFuture<BookUrlEntity> call(DataMap params) async =>
      _repository.downloadBook(params);
}
