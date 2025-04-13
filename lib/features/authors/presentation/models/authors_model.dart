import 'package:equatable/equatable.dart';
import 'package:foursquare_ebbok_app/features/authors/domain/entity/author_entity.dart';

import '../../domain/entity/author_details_entity.dart';

class AuthorsModel extends Equatable {
  const AuthorsModel({
    required this.getAuthorsNetworkModel,
    required this.getSingleAuthorNetworkModel,
  });

  const AuthorsModel.initial()
      : this(
            getAuthorsNetworkModel: const GetAuthorsNetworkModel.initial(),
            getSingleAuthorNetworkModel:
                const GetSingleAuthorNetworkModel.initial());

  final GetAuthorsNetworkModel getAuthorsNetworkModel;
  final GetSingleAuthorNetworkModel getSingleAuthorNetworkModel;

  AuthorsModel copyWith({
    GetAuthorsNetworkModel? getAuthorsNetworkModel,
    GetSingleAuthorNetworkModel? getSingleAuthorNetworkModel,
  }) {
    return AuthorsModel(
      getAuthorsNetworkModel:
          getAuthorsNetworkModel ?? this.getAuthorsNetworkModel,
      getSingleAuthorNetworkModel:
          getSingleAuthorNetworkModel ?? this.getSingleAuthorNetworkModel,
    );
  }

  @override
  List<Object?> get props => [
        getAuthorsNetworkModel,
        getSingleAuthorNetworkModel,
      ];
}

class GetAuthorsNetworkModel extends Equatable {
  const GetAuthorsNetworkModel({
    required this.loading,
    required this.error,
    required this.loaded,
    required this.authors,
  });

  final bool loading;
  final String error;
  final bool loaded;
  final List<AuthorEntity> authors;

  const GetAuthorsNetworkModel.initial()
      : this(
          loading: false,
          error: '',
          loaded: false,
          authors: const [],
        );

  bool get hasError => error.isNotEmpty;
  bool get newLoading => loading && !loaded;

  GetAuthorsNetworkModel copyWith({
    bool? loading,
    String? error,
    bool? loaded,
    List<AuthorEntity>? authors,
  }) {
    return GetAuthorsNetworkModel(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      loaded: loaded ?? this.loaded,
      authors: authors ?? this.authors,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        error,
        loaded,
        authors,
      ];
}

class GetSingleAuthorNetworkModel extends Equatable {
  const GetSingleAuthorNetworkModel({
    required this.loading,
    required this.error,
    required this.loaded,
    required this.author,
  });

  final bool loading;
  final String error;
  final bool loaded;
  final AuthorDetailsEntity author;

  const GetSingleAuthorNetworkModel.initial()
      : this(
          loading: false,
          error: '',
          loaded: false,
          author: const AuthorDetailsEntity.initial(),
        );

  bool get hasError => error.isNotEmpty;

  GetSingleAuthorNetworkModel copyWith({
    bool? loading,
    String? error,
    bool? loaded,
    AuthorDetailsEntity? author,
  }) {
    return GetSingleAuthorNetworkModel(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      loaded: loaded ?? this.loaded,
      author: author ?? this.author,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        error,
        loaded,
        author,
      ];
}
