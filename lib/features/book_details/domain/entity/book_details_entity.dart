import 'package:equatable/equatable.dart';

class BookDetailsEntity extends Equatable {
  const BookDetailsEntity({
    required this.bookId,
    required this.favStatus,
    required this.purchasedStatus,
    required this.bookAccess,
    required this.bookImg,
    required this.bookTitle,
    required this.authorName,
    required this.bookPrice,
    required this.bookDescription,
    required this.bookReviewCount,
    required this.bookAverageRating,
    required this.postViewCount,
    required this.relatedBookList,
  });

  const BookDetailsEntity.initial()
      : this(
          bookId: '',
          favStatus: false,
          purchasedStatus: false,
          bookAccess: '',
          bookImg: '',
          bookTitle: '',
          authorName: '',
          bookPrice: '',
          bookDescription: '',
          bookReviewCount: 0,
          bookAverageRating: 0,
          postViewCount: '',
          relatedBookList: const [],
        );

  double parseBookPrice(String bookPrice) {
    // Trim whitespace and convert to lowercase for safety
    final price = bookPrice.trim().toLowerCase();

    if (price == 'free') {
      return 0;
    }

    // Remove non-numeric characters except dot
    final cleaned = price.replaceAll(RegExp(r'[^\d.]'), '');

    // Parse to double (or int if you prefer)
    return double.tryParse(cleaned) ?? 0;
  }


  final String bookId;
  final bool favStatus;
  final bool purchasedStatus;
  final String bookAccess;
  final String bookImg;
  final String bookTitle;
  final String authorName;
  final String bookPrice;
  final String bookDescription;
  final int bookReviewCount;
  final int bookAverageRating;
  final String postViewCount;
  final List<RelatedBookEntity> relatedBookList;

  double get parsedPrice => parseBookPrice(bookPrice);

  double get paystackPrice => parsedPrice * 100;

  String get flutterwavePrice => parsedPrice.toString();

  @override
  List<Object?> get props => [
        bookId,
        favStatus,
        purchasedStatus,
        bookAccess,
        bookImg,
        bookTitle,
        authorName,
        bookPrice,
        bookDescription,
        bookReviewCount,
        bookAverageRating,
        postViewCount,
        relatedBookList,
      ];
}

class RelatedBookEntity extends Equatable {
  const RelatedBookEntity({
    required this.relatedBookId,
    required this.relatedBookAuthor,
    required this.relatedBookTitle,
    required this.realatedBookImage,
    required this.relatedBookPrice,
    required this.relatedBookRatingCount,
  });

  final String relatedBookId;
  final String relatedBookAuthor;
  final String relatedBookTitle;
  final String realatedBookImage;
  final String relatedBookPrice;
  final double relatedBookRatingCount;

  @override
  List<Object?> get props => [
        relatedBookId,
        relatedBookAuthor,
        relatedBookTitle,
        realatedBookImage,
        relatedBookPrice,
        relatedBookRatingCount,
      ];
}
