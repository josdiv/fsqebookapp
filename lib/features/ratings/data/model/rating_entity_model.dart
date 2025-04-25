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
    String formatDate(String inputDate) {
      final DateTime dateTime = DateTime.parse(inputDate);
      final List<String> months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      String day = dateTime.day.toString().padLeft(2, '0');
      String month = months[dateTime.month - 1];
      String year = dateTime.year.toString();

      return '$day, $month $year';
    }

    return RatingEntityModel(
      profileImage: json['profileImage'] as String,
      profileName: json['profileName'] as String,
      rating: json['rating'] as String,
      ratingDate: formatDate(json['ratingDate'] as String),
      review: json['review'] as String,
    );
  }
}
