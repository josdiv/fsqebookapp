import 'package:equatable/equatable.dart';
import 'package:foursquare_ebbok_app/features/ratings/domain/entity/rating_entity.dart';

class RatingScreenModel extends Equatable {
  const RatingScreenModel({
    required this.loading,
    required this.error,
    required this.loaded,
    required this.ratings,
    required this.currentRatingValue,
  });

  const RatingScreenModel.initial()
      : this(
          loading: false,
          error: '',
          loaded: false,
          ratings: const [],
          currentRatingValue: RatingsValue.all,
        );

  final bool loading;
  final String error;
  final bool loaded;
  final List<RatingEntity> ratings;
  final RatingsValue currentRatingValue;

  bool get hasError => error.isNotEmpty;

  List<RatingEntity> get getRatings0 =>
      ratings.where((rating) => rating.rating == '0').toList();

  List<RatingEntity> get getRatings1 =>
      ratings.where((rating) => rating.rating == '1').toList();

  List<RatingEntity> get getRatings2 =>
      ratings.where((rating) => rating.rating == '2').toList();

  List<RatingEntity> get getRatings3 =>
      ratings.where((rating) => rating.rating == '3').toList();

  List<RatingEntity> get getRatings4 =>
      ratings.where((rating) => rating.rating == '4').toList();

  List<RatingEntity> get getRatings5 =>
      ratings.where((rating) => rating.rating == '5').toList();

  RatingScreenModel selectAll() => copyWith(
        currentRatingValue: RatingsValue.all,
      );

  RatingScreenModel selectZero() => copyWith(
    currentRatingValue: RatingsValue.zero,
  );

  RatingScreenModel selectOne() => copyWith(
        currentRatingValue: RatingsValue.one,
      );

  RatingScreenModel selectTwo() => copyWith(
        currentRatingValue: RatingsValue.two,
      );

  RatingScreenModel selectThree() => copyWith(
        currentRatingValue: RatingsValue.three,
      );

  RatingScreenModel selectFour() => copyWith(
        currentRatingValue: RatingsValue.four,
      );

  RatingScreenModel selectFive() => copyWith(
        currentRatingValue: RatingsValue.five,
      );

  RatingScreenModel copyWith({
    bool? loading,
    String? error,
    bool? loaded,
    List<RatingEntity>? ratings,
    RatingsValue? currentRatingValue,
  }) {
    return RatingScreenModel(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      loaded: loaded ?? this.loaded,
      ratings: ratings ?? this.ratings,
      currentRatingValue: currentRatingValue ?? this.currentRatingValue,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        error,
        loaded,
        ratings,
        currentRatingValue,
      ];
}

enum RatingsValue { all, zero, one, two, three, four, five }
