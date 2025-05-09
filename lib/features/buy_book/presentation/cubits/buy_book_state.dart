part of 'buy_book_cubit.dart';

sealed class BuyBookState extends Equatable {
  const BuyBookState([this.model = const BuyBookModel.initial()]);

  final BuyBookModel model;

  @override
  List<Object> get props => [model];
}

final class BuyBookInitial extends BuyBookState {}

final class BuyBookScreenState extends BuyBookState {
  const BuyBookScreenState(super.model);
}