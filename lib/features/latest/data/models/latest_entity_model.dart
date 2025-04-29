import '../../domain/entity/latest_entity.dart';

class LatestEntityModel extends LatestEntity {
  const LatestEntityModel({
    required super.bookId,
    required super.authorName,
    required super.bookTitle,
    required super.bookImage,
    required super.bookPrice,
    required super.bookAccess,
    required super.ratingCount,
    required super.postViewCount,
  });

  factory LatestEntityModel.fromJson(Map<String, dynamic> json) {
    return LatestEntityModel(
      bookId: json["bookId"].toString(),
      authorName: json["authorName"],
      bookTitle: json["bookTitle"],
      bookImage: json["bookImage"],
      bookPrice: json["bookPrice"],
      bookAccess: json["bookAccess"],
      ratingCount: (json["ratingCount"] as num).toInt(),
      postViewCount: json["postViewCount"],
    );
  }
}
