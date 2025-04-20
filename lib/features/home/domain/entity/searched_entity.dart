import 'package:equatable/equatable.dart';

class SearchedEntity extends Equatable {
  const SearchedEntity({
    required this.bookId,
    required this.bookTitle,
    required this.bookImage,
    required this.bookPrice,
    required this.bookRating,
  });

  final String bookId;
  final String bookTitle;
  final String bookImage;
  final String bookPrice;
  final String bookRating;

  @override
  List<Object?> get props => [
        bookId,
        bookTitle,
        bookImage,
        bookPrice,
        bookRating,
      ];
}
