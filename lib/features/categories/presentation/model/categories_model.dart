import 'package:equatable/equatable.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/entity/category_entity.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/entity/sub_category_details_entity.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/entity/sub_category_entity.dart';

class CategoriesModel extends Equatable {
  const CategoriesModel({
    required this.model1,
    required this.model2,
    required this.model3,
  });

  const CategoriesModel.initial()
      : this(
          model1: const CategoriesScreenModel.initial(),
          model2: const SubCategoriesScreenModel.initial(),
          model3: const SubCategoriesDetailsScreenModel.initial(),
        );

  final CategoriesScreenModel model1;
  final SubCategoriesScreenModel model2;
  final SubCategoriesDetailsScreenModel model3;

  CategoriesModel copyWith({
    CategoriesScreenModel? model1,
    SubCategoriesScreenModel? model2,
    SubCategoriesDetailsScreenModel? model3,
  }) {
    return CategoriesModel(
      model1: model1 ?? this.model1,
      model2: model2 ?? this.model2,
      model3: model3 ?? this.model3,
    );
  }

  @override
  List<Object?> get props => [
        model1,
        model2,
        model3,
      ];
}

class CategoriesScreenModel extends Equatable {
  const CategoriesScreenModel({
    required this.loading,
    required this.error,
    required this.loaded,
    required this.categories,
  });

  final bool loading;
  final String error;
  final bool loaded;
  final List<CategoryEntity> categories;

  const CategoriesScreenModel.initial()
      : this(
          loading: false,
          error: '',
          loaded: false,
          categories: const [],
        );

  bool get hasError => error.isNotEmpty;

  bool get newLoading => loading && !loaded;

  CategoriesScreenModel copyWith({
    bool? loading,
    String? error,
    bool? loaded,
    List<CategoryEntity>? categories,
  }) {
    return CategoriesScreenModel(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      loaded: loaded ?? this.loaded,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        error,
        loaded,
        categories,
      ];
}

class SubCategoriesScreenModel extends Equatable {
  const SubCategoriesScreenModel({
    required this.loading,
    required this.error,
    required this.loaded,
    required this.categoryName,
    required this.subCategories,
  });

  final bool loading;
  final String error;
  final String categoryName;
  final bool loaded;
  final List<SubCategoryEntity> subCategories;

  const SubCategoriesScreenModel.initial()
      : this(
          loading: false,
          error: '',
          loaded: false,
          subCategories: const [],
          categoryName: '',
        );

  bool get hasError => error.isNotEmpty;

  SubCategoriesScreenModel copyWith({
    bool? loading,
    String? error,
    String? categoryName,
    bool? loaded,
    List<SubCategoryEntity>? subCategories,
  }) {
    return SubCategoriesScreenModel(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      loaded: loaded ?? this.loaded,
      subCategories: subCategories ?? this.subCategories,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        error,
        loaded,
        subCategories,
        categoryName,
      ];
}

class SubCategoriesDetailsScreenModel extends Equatable {
  const SubCategoriesDetailsScreenModel({
    required this.loading,
    required this.error,
    required this.loaded,
    required this.subCategoryName,
    required this.subCategoryDetails,
  });

  final bool loading;
  final String error;
  final String subCategoryName;
  final bool loaded;
  final List<SubCategoryDetailsEntity> subCategoryDetails;

  const SubCategoriesDetailsScreenModel.initial()
      : this(
          loading: false,
          error: '',
          loaded: false,
          subCategoryDetails: const [],
          subCategoryName: '',
        );

  bool get hasError => error.isNotEmpty;

  SubCategoriesDetailsScreenModel copyWith({
    bool? loading,
    String? error,
    String? subCategoryName,
    bool? loaded,
    List<SubCategoryDetailsEntity>? subCategoryDetails,
  }) {
    return SubCategoriesDetailsScreenModel(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      loaded: loaded ?? this.loaded,
      subCategoryDetails: subCategoryDetails ?? this.subCategoryDetails,
      subCategoryName: subCategoryName ?? this.subCategoryName,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        error,
        loaded,
        subCategoryDetails,
        subCategoryName,
      ];
}
