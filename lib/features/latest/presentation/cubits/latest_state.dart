part of 'latest_cubit.dart';

sealed class LatestState extends Equatable {
  const LatestState([this.isLoaded = false]);

  final bool isLoaded;

  @override
  List<Object> get props => [isLoaded];
}

final class LatestInitial extends LatestState {}

final class LatestBooksLoading extends LatestState {
  const LatestBooksLoading(super.isLoaded);
}

final class LatestBooksError extends LatestState {
  const LatestBooksError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

final class LatestBooksLoaded extends LatestState {
  const LatestBooksLoaded(
    super.isLoaded,
    this.latestBooks,
  );

  final List<LatestEntity> latestBooks;

  @override
  List<Object> get props => [latestBooks];
}
