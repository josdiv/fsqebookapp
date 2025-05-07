import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/entity/book_details_entity.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/entity/book_url_entity.dart';

abstract interface class BookDetailsRepository {
  ResultFuture<BookDetailsEntity> getBookDetails(DataMap data);

  ResultVoid reportBook(DataMap data);

  ResultFuture<String> toggleFavourite(DataMap data);

  ResultFuture<BookUrlEntity> readBook(DataMap data);

  ResultFuture<BookUrlEntity> downloadBook(DataMap data);

  ResultVoid writeReview(DataMap data);
}
