import '../../domain/entity/author_entity.dart';

class AuthorEntityModel extends AuthorEntity {
  const AuthorEntityModel({
    required super.authorId,
    required super.authorName,
    required super.authorImage,
  });

  factory AuthorEntityModel.fromJson(Map<String, dynamic> json) {
    return AuthorEntityModel(
      authorId: json["authorId"].toString(),
      authorName: json["authorName"],
      authorImage: json["authorImage"],
    );
  }
}