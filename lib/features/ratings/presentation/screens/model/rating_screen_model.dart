import 'package:equatable/equatable.dart';
import 'package:foursquare_ebbok_app/features/ratings/domain/entity/rating_entity.dart';

class RatingScreenModel extends Equatable {
  const RatingScreenModel({
    required this.loading,
    required this.error,
    required this.loaded,
    required this.ratings,
  });

  const RatingScreenModel.initial()
      : this(
          loading: false,
          error: '',
          loaded: false,
          ratings: const [],
        );

  final bool loading;
  final String error;
  final bool loaded;
  final List<RatingEntity> ratings;

  bool get hasError => error.isNotEmpty;

  RatingScreenModel copyWith({
    bool? loading,
    String? error,
    bool? loaded,
    List<RatingEntity>? ratings,
  }) {
    return RatingScreenModel(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      loaded: loaded ?? this.loaded,
      ratings: ratings ?? this.ratings,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        error,
        loaded,
        ratings,
      ];
}
