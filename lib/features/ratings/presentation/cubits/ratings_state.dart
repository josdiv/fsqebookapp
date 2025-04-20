part of 'ratings_cubit.dart';

sealed class RatingsState extends Equatable {
  const RatingsState([this.model = const RatingModel.initial()]);

  final RatingModel model;

  @override
  List<Object> get props => [model];
}

final class RatingsInitial extends RatingsState {}

final class RatingsScreenState extends RatingsState {
  const RatingsScreenState(super.model);
}
