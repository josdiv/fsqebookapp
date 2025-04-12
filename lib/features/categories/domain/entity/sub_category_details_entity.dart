import 'package:equatable/equatable.dart';

class SubCategoryDetailsEntity extends Equatable {
  const SubCategoryDetailsEntity({
    required this.bookId,
    required this.authorName,
    required this.bookTitle,
    required this.bookImage,
    required this.bookPrice,
    required this.bookRating,
  });

  final String bookId;
  final String authorName;
  final String bookTitle;
  final String bookImage;
  final String bookPrice;
  final String bookRating;

  @override
  List<Object?> get props => [
        bookId,
        authorName,
        bookTitle,
        bookImage,
        bookPrice,
        bookRating,
      ];
}
