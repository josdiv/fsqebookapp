import 'package:equatable/equatable.dart';

class AuthorDetailsEntity extends Equatable {
  const AuthorDetailsEntity({
    required this.authorName,
    required this.authorImage,
    required this.authorInfo,
    required this.numberOfAuthorBooks,
    required this.authorBooks,
  });

  final String authorName;
  final String authorImage;
  final String authorInfo;
  final String numberOfAuthorBooks;
  final List<AuthorDetailsBookEntity> authorBooks;

  const AuthorDetailsEntity.initial()
      : this(
          authorName: '',
          authorImage: '',
          authorInfo: '',
          numberOfAuthorBooks: '',
          authorBooks: const [],
        );

  @override
  List<Object?> get props => [
        authorName,
        authorImage,
        authorInfo,
        numberOfAuthorBooks,
        authorBooks,
      ];
}

class AuthorDetailsBookEntity {
  const AuthorDetailsBookEntity({
    required this.bookId,
    required this.bookTitle,
    required this.bookImage,
    required this.bookPrice,
    required this.bookRating,
  });

  bool get isFree => bookPrice.toLowerCase() == 'free';

  final String bookId;
  final String bookTitle;
  final String bookImage;
  final String bookPrice;
  final String bookRating;
}
