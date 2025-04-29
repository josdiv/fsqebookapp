import '../../../../core/utils/typedefs/typedefs.dart';
import '../../domain/entity/author_details_entity.dart';
import 'package:html/parser.dart' as html_parser;

class AuthorDetailsEntityModel extends AuthorDetailsEntity {
  const AuthorDetailsEntityModel({
    required super.authorName,
    required super.authorImage,
    required super.authorInfo,
    required super.numberOfAuthorBooks,
    required super.authorBooks,
  });

  factory AuthorDetailsEntityModel.fromJson(DataMap json) {
    final document = html_parser.parse(json['authorInfo'] as String);
    final authorInfo = document.body?.text ?? 'No content found';
    final dynamicBooks = json['authorBooks'] as List<dynamic>;
    print(json['authorBooks']);
    final authorBooks = dynamicBooks.map((book) =>
        AuthorDetailsBookEntityModel.fromJson(book as DataMap)).toList();

    return AuthorDetailsEntityModel(
      authorName: json['authorName'] as String,
      authorImage: json['authorImage'] as String,
      authorInfo: authorInfo,
      numberOfAuthorBooks: (json['numberOfAuthorBooks'] as num).toString(),
      authorBooks: authorBooks,
    );
  }
}

class AuthorDetailsBookEntityModel extends AuthorDetailsBookEntity {
  const AuthorDetailsBookEntityModel({
    required super.bookId,
    required super.bookTitle,
    required super.bookImage,
    required super.bookPrice,
    required super.bookRating,
  });

  factory AuthorDetailsBookEntityModel.fromJson(DataMap json) {

    return AuthorDetailsBookEntityModel(
      bookId: json['bookId'].toString(),
      bookTitle: json['bookTitle'] as String,
      bookImage: json['bookImage'] as String,
      bookPrice: json['bookPrice'] as String,
      bookRating: ((json['bookRating'] as num).toDouble()).toStringAsFixed(2),
    );
  }
}
