import 'package:equatable/equatable.dart';

class BookUrlEntity extends Equatable {
  const BookUrlEntity({
    required this.bookUrl,
    required this.bookExtension,
  });

  const BookUrlEntity.initial()
      : this(
          bookUrl: '',
          bookExtension: '',
        );

  bool get isPdf => bookExtension.toLowerCase() == 'pdf';

  final String bookUrl;
  final String bookExtension;

  @override
  List<Object?> get props => [bookUrl, bookExtension];
}
