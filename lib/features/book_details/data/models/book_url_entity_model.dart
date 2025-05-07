import '../../domain/entity/book_url_entity.dart';

class BookUrlEntityModel extends BookUrlEntity {
  const BookUrlEntityModel({
    required super.bookUrl,
    required super.bookExtension,
  });

  factory BookUrlEntityModel.fromMap(Map<String, dynamic> map) {
    return BookUrlEntityModel(
      bookUrl: map['bookUrl'] as String,
      bookExtension: map['bookExtension'] as String,
    );
  }
}
