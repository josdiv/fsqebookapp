import 'package:equatable/equatable.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/entity/book_url_entity.dart';

class DownloadBookModel extends Equatable {
  const DownloadBookModel({
    required this.loading,
    required this.error,
    required this.loaded,
    required this.entity,
  });

  final bool loading;
  final String error;
  final bool loaded;
  final BookUrlEntity entity;

  const DownloadBookModel.initial()
      : this(
          loading: false,
          error: '',
          loaded: false,
          entity: const BookUrlEntity.initial(),
        );

  bool get hasError => error.isNotEmpty;

  DownloadBookModel copyWith({
    bool? loading,
    String? error,
    bool? loaded,
    BookUrlEntity? entity,
  }) {
    return DownloadBookModel(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      loaded: loaded ?? this.loaded,
      entity: entity ?? this.entity,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        error,
        loaded,
        entity,
      ];
}
