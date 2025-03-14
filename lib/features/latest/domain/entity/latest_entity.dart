import 'package:equatable/equatable.dart';

class LatestEntity extends Equatable {
  const LatestEntity({
    required this.bookId,
    required this.authorName,
    required this.bookTitle,
    required this.bookImage,
    required this.bookPrice,
    required this.bookAccess,
    required this.ratingCount,
    required this.postViewCount,
  });

  final String bookId;
  final String authorName;
  final String bookTitle;
  final String bookImage;
  final String bookPrice;
  final String bookAccess;
  final int ratingCount;
  final String postViewCount;

  @override
  List<Object?> get props => [
        bookId,
        authorName,
        bookTitle,
        bookImage,
        bookPrice,
        bookAccess,
        ratingCount,
        postViewCount,
      ];
}
