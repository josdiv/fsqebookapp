import '../../../../core/utils/typedefs/typedefs.dart';
import '../../domain/entity/author_details_entity.dart';
import 'package:html/parser.dart' as html_parser;

class AuthorDetailsEntityModel extends AuthorDetailsEntity {
  const AuthorDetailsEntityModel({
    required super.authorName,
    required super.authorImage,
    required super.authorInfo,
    required super.numberOfAuthorBooks,
    required super.bookId,
    required super.bookPrice,
    required super.bookAccess,
    required super.bookTitle,
    required super.bookImage,
    required super.bookRating,
  });

  factory AuthorDetailsEntityModel.fromJson(DataMap json) {
    final document = html_parser.parse(json['authorInfo'] as String);
    final authorInfo = document.body?.text ?? 'No content found';
    return AuthorDetailsEntityModel(
      authorName: json['authorName'] as String,
      authorImage: json['authorImage'] as String,
      authorInfo: authorInfo,
      numberOfAuthorBooks: (json['numberOfAuthorBooks'] as num).toString(),
      bookId: json['bookId'] as String,
      bookPrice: json['bookPrice'] as String,
      bookAccess: json['bookAccess'] as String,
      bookTitle: json['bookTitle'] as String,
      bookImage: json['bookImage'] as String,
      bookRating: (json['bookRating'] as num).toDouble(),
    );
  }
}