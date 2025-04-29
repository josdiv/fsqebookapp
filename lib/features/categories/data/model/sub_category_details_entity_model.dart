import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/entity/sub_category_details_entity.dart';

class SubCategoryDetailsEntityModel extends SubCategoryDetailsEntity {
  const SubCategoryDetailsEntityModel({
    required super.bookId,
    required super.authorName,
    required super.bookTitle,
    required super.bookImage,
    required super.bookPrice,
    required super.bookRating,
  });

  factory SubCategoryDetailsEntityModel.fromJson(DataMap json) {
    return SubCategoryDetailsEntityModel(
      bookId: (json['bookId'] as num).toString(),
      authorName: json['authorName'] as String,
      bookTitle: json['bookTitle'] as String,
      bookImage: json['bookImage'] as String,
      bookPrice: json['bookPrice'] as String,
      bookRating: (json['bookRating'] as num).toString(),
    );
  }
}
