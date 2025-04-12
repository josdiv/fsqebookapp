import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/entity/book_details_entity.dart';
import 'package:html/parser.dart' as html_parser;

class BookDetailsEntityModel extends BookDetailsEntity {
  const BookDetailsEntityModel({
    required super.bookId,
    required super.bookAccess,
    required super.bookImg,
    required super.bookTitle,
    required super.authorName,
    required super.bookPrice,
    required super.bookDescription,
    required super.bookReviewCount,
    required super.bookAverageRating,
    required super.postViewCount,
    required super.relatedBookList,
  });

  factory BookDetailsEntityModel.fromJson(DataMap json) {
    final bookDetail = json['bookDetail'] as DataMap;
    final dynamicList = json['relatedBookList'] as List<dynamic>;

    final relatedBookList = dynamicList
        .map(
          (e) => RelatedBookEntityModel.fromJson(
            e as DataMap,
          ),
        )
        .toList();

    final document = html_parser.parse(bookDetail['bookDescription'] as String);

    final bookDescription = document.body?.text ?? "No content found";

    return BookDetailsEntityModel(
      bookId: bookDetail['bookId'] as String,
      bookAccess: bookDetail['bookAccess'] as String,
      bookImg: bookDetail['bookImg'] as String,
      bookTitle: bookDetail['bookTitle'] as String,
      authorName: bookDetail['authorName'] as String,
      bookPrice: bookDetail['bookPrice'] as String,
      bookDescription: bookDescription,
      bookReviewCount: (bookDetail['bookReviewCount'] as num).toInt(),
      bookAverageRating: bookDetail['bookAverageRating'] == ""
          ? 0
          : (bookDetail['bookAverageRating'] as num).toInt(),
      postViewCount: bookDetail['postViewCount'] as String,
      relatedBookList: relatedBookList,
    );
  }
}

class RelatedBookEntityModel extends RelatedBookEntity {
  const RelatedBookEntityModel({
    required super.relatedBookId,
    required super.relatedBookAuthor,
    required super.relatedBookTitle,
    required super.realatedBookImage,
    required super.relatedBookPrice,
    required super.relatedBookRatingCount,
  });

  factory RelatedBookEntityModel.fromJson(DataMap json) {
    return RelatedBookEntityModel(
      relatedBookId: json['relatedBookId'] as String,
      relatedBookAuthor: json['relatedBookAuthor'] as String,
      relatedBookTitle: json['relatedBookTitle'] as String,
      realatedBookImage: json['realatedBookImage'] as String,
      relatedBookPrice: json['relatedBookPrice'] as String,
      relatedBookRatingCount:
          (json['relatedBookRatingCount'] as num).toDouble(),
    );
  }
}
