import 'package:equatable/equatable.dart';

class RatingEntity extends Equatable {
  const RatingEntity({
    required this.profileImage,
    required this.profileName,
    required this.rating,
    required this.ratingDate,
    required this.review,
  });

  final String profileImage;
  final String profileName;
  final String rating;
  final String ratingDate;
  final String review;

  @override
  // TODO: implement props
  List<Object?> get props => [
        profileImage,
        profileName,
        rating,
        ratingDate,
        review,
      ];
}
