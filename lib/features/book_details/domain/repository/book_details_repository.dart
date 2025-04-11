import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/entity/book_details_entity.dart';

abstract interface class BookDetailsRepository {
  ResultFuture<BookDetailsEntity> getBookDetails(String id);
}
