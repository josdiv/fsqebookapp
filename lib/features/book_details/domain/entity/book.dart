import 'package:equatable/equatable.dart';

class Book extends Equatable {
  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.path,
    required this.downloadedAt,
  });

  final String id;
  final String title;
  final String author;
  final String coverUrl;
  final String path;
  final String downloadedAt;

  @override
  List<Object?> get props => [
        id,
        title,
        author,
        coverUrl,
        path,
        downloadedAt,
      ];

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] as String,
      title: map['title'] as String,
      author: map['author'] as String,
      coverUrl: map['coverUrl'] as String,
      path: map['path'] as String,
      downloadedAt: map['downloadedAt'] as String,
    );
  }
}
