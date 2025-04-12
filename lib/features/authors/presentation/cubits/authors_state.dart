part of 'authors_cubit.dart';

sealed class AuthorsState extends Equatable {
  const AuthorsState([this.model = const AuthorsModel.initial()]);

  final AuthorsModel model;

  @override
  List<Object> get props => [model];
}

final class AuthorsInitial extends AuthorsState {}

final class AuthorScreenState extends AuthorsState {
  const AuthorScreenState(super.model);
}
