import 'package:equatable/equatable.dart';

class AuthorDetailsEntity extends Equatable {
  const AuthorDetailsEntity({
    required this.authorName,
    required this.authorImage,
    required this.authorInfo,
    required this.numberOfAuthorBooks,
    required this.bookId,
    required this.bookPrice,
    required this.bookAccess,
    required this.bookTitle,
    required this.bookImage,
    required this.bookRating,
  });

  final String authorName;
  final String authorImage;
  final String authorInfo;
  final String numberOfAuthorBooks;
  final String bookId;
  final String bookPrice;
  final String bookAccess;
  final String bookTitle;
  final String bookImage;
  final double bookRating;

  const AuthorDetailsEntity.initial()
      : this(
          authorName: '',
          authorImage: '',
          authorInfo: '',
          numberOfAuthorBooks: '',
          bookId: '',
          bookPrice: '',
          bookAccess: '',
          bookTitle: '',
          bookImage: '',
          bookRating: 0,
        );

  @override
  List<Object?> get props => [
        authorName,
        authorImage,
        authorInfo,
        numberOfAuthorBooks,
        bookId,
        bookPrice,
        bookAccess,
        bookImage,
        bookRating,
      ];
}
