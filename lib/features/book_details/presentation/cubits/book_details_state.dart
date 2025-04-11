part of 'book_details_cubit.dart';

sealed class BookDetailsState extends Equatable {
  const BookDetailsState();

  @override
  List<Object> get props => [];
}

final class BookDetailsInitial extends BookDetailsState {}

final class BookDetailsLoadingState extends BookDetailsState {}

final class BookDetailsErrorState extends BookDetailsState {
  const BookDetailsErrorState(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

final class BookDetailsLoadedState extends BookDetailsState {
  const BookDetailsLoadedState(this.entity);

  final BookDetailsEntity entity;

  @override
  List<Object> get props => [entity];
}
