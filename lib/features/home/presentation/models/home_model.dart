import 'package:equatable/equatable.dart';
import 'package:foursquare_ebbok_app/features/home/domain/entity/home_entity.dart';
import 'package:foursquare_ebbok_app/features/home/domain/entity/searched_entity.dart';

class HomeModel extends Equatable {
  const HomeModel({
    required this.model1,
    required this.model2,
    required this.model3,
  });

  const HomeModel.initial()
      : this(
          model1: const HomeScreenModel.initial(),
          model2: const SearchedBooksModel.initial(),
          model3: const DeleteAccountModel.initial(),
        );

  final HomeScreenModel model1;
  final SearchedBooksModel model2;
  final DeleteAccountModel model3;

  HomeModel copyWith({
    HomeScreenModel? model1,
    SearchedBooksModel? model2,
    DeleteAccountModel? model3,
  }) {
    return HomeModel(
      model1: model1 ?? this.model1,
      model2: model2 ?? this.model2,
      model3: model3 ?? this.model3,
    );
  }

  @override
  List<Object?> get props => [model1, model2, model3];
}

class SearchedBooksModel extends Equatable {
  const SearchedBooksModel({
    required this.loading,
    required this.error,
    required this.loaded,
    required this.searchedBooks,
  });

  const SearchedBooksModel.initial()
      : this(
          loading: false,
          error: '',
          loaded: false,
          searchedBooks: const [],
        );

  final bool loading;
  final String error;
  final bool loaded;
  final List<SearchedEntity> searchedBooks;

  bool get hasError => error.isNotEmpty;

  bool get loadOnce => loading && !loaded;

  SearchedBooksModel copyWith({
    bool? loading,
    String? error,
    bool? loaded,
    List<SearchedEntity>? searchedBooks,
  }) {
    return SearchedBooksModel(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      loaded: loaded ?? this.loaded,
      searchedBooks: searchedBooks ?? this.searchedBooks,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        error,
        loaded,
        searchedBooks,
      ];
}

class HomeScreenModel extends Equatable {
  const HomeScreenModel({
    required this.loading,
    required this.error,
    required this.loaded,
    required this.homeData,
  });

  const HomeScreenModel.initial()
      : this(
          loading: false,
          error: '',
          loaded: false,
          homeData: const HomeEntity.initial(),
        );

  final bool loading;
  final String error;
  final bool loaded;
  final HomeEntity homeData;

  bool get hasError => error.isNotEmpty;

  bool get loadOnce => loading && !loaded;

  HomeScreenModel copyWith({
    bool? loading,
    String? error,
    bool? loaded,
    HomeEntity? homeData,
  }) {
    return HomeScreenModel(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      loaded: loaded ?? this.loaded,
      homeData: homeData ?? this.homeData,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        error,
        loaded,
        homeData,
      ];
}

class DeleteAccountModel extends Equatable {
  const DeleteAccountModel({
    required this.loading,
    required this.error,
    required this.loaded,
  });

  const DeleteAccountModel.initial()
      : this(
          loading: false,
          error: '',
          loaded: false,
        );

  final bool loading;
  final String error;
  final bool loaded;

  bool get hasError => error.isNotEmpty;

  bool get loadOnce => loading && !loaded;

  DeleteAccountModel copyWith({
    bool? loading,
    String? error,
    bool? loaded,
  }) {
    return DeleteAccountModel(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      loaded: loaded ?? this.loaded,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        error,
        loaded,
      ];
}
