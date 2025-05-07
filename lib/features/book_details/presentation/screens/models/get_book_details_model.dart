import 'package:equatable/equatable.dart';

import '../../../domain/entity/book_details_entity.dart';

class GetBookDetailsModel extends Equatable {
  const GetBookDetailsModel({
    required this.loading,
    required this.error,
    required this.loaded,
    required this.entity,
  });

  final bool loading;
  final String error;
  final bool loaded;
  final BookDetailsEntity entity;

  const GetBookDetailsModel.initial()
      : this(
          loading: false,
          error: '',
          loaded: false,
          entity: const BookDetailsEntity.initial(),
        );

  bool get hasError => error.isNotEmpty;

  GetBookDetailsModel copyWith({
    bool? loading,
    String? error,
    bool? loaded,
    BookDetailsEntity? entity,
  }) {
    return GetBookDetailsModel(
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
