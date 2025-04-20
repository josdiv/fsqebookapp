import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/home/domain/entity/searched_entity.dart';

class SearchedEntityModel extends SearchedEntity {
  const SearchedEntityModel({
    required super.bookId,
    required super.bookTitle,
    required super.bookImage,
    required super.bookPrice,
    required super.bookRating,
  });

  factory SearchedEntityModel.fromJson(DataMap json) {
    return SearchedEntityModel(
      bookId: json['bookId'] as String,
      bookTitle: json['bookTitle'] as String,
      bookImage: json['bookImage'] as String,
      bookPrice: json['bookPrice'] as String,
      bookRating: json['bookRating'] as String,
    );
  }
}
