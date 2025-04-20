import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';

import '../../domain/entity/rating_entity.dart';

class RatingEntityModel extends RatingEntity {
  const RatingEntityModel({
    required super.profileImage,
    required super.profileName,
    required super.rating,
    required super.ratingDate,
    required super.review,
  });

  factory RatingEntityModel.fromJson(DataMap json) {
    return RatingEntityModel(
      profileImage: json['profileImage'] as String,
      profileName: json['profileName'] as String,
      rating: json['rating'] as String,
      ratingDate: json['ratingDate'] as String,
      review: json['review'] as String,
    );
  }
}
