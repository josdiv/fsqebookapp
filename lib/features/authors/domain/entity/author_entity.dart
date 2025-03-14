import 'package:equatable/equatable.dart';

class AuthorEntity extends Equatable {
  const AuthorEntity({
    required this.authorId,
    required this.authorName,
    required this.authorImage,
  });

  final String authorId;
  final String authorName;
  final String authorImage;

  @override
  List<Object?> get props => [
        authorId,
        authorName,
        authorImage,
      ];
}
