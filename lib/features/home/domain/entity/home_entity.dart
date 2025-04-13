import 'package:equatable/equatable.dart';

class HomeEntity extends Equatable {
  const HomeEntity({
    required this.featuredBookTitle,
    required this.featuredBookList,
    required this.trendingBookTitle,
    required this.trendingBookList,
    required this.manualBookTitle,
    required this.manualBookList,
    required this.subcategoryBookTitle,
    required this.subCategoryBookList,
    required this.workbookTitle,
    required this.workbookList,
  });

  final String featuredBookTitle;
  final List<HomeFeaturedBookList> featuredBookList;
  final String trendingBookTitle;
  final List<HomeTrendingBookList> trendingBookList;
  final String manualBookTitle;
  final List<HomeManualBookList> manualBookList;
  final String subcategoryBookTitle;
  final List<HomeSubCategoryBookList> subCategoryBookList;
  final String workbookTitle;
  final List<HomeWorkbookList> workbookList;

  const HomeEntity.initial()
      : this(
          featuredBookTitle: '',
          featuredBookList: const [],
          trendingBookTitle: '',
          trendingBookList: const [],
          manualBookTitle: '',
          manualBookList: const [],
          subcategoryBookTitle: '',
          subCategoryBookList: const [],
          workbookTitle: '',
          workbookList: const [],
        );

  @override
  List<Object?> get props => [
        featuredBookTitle,
        featuredBookList,
        trendingBookTitle,
        trendingBookList,
        manualBookTitle,
        manualBookList,
        subcategoryBookTitle,
        subCategoryBookList,
        workbookTitle,
        workbookList,
      ];
}

class HomeFeaturedBookList extends Equatable {
  const HomeFeaturedBookList({
    required this.featuredId,
    required this.featuredTitle,
    required this.featuredImage,
  });

  final String featuredId;
  final String featuredTitle;
  final String featuredImage;

  @override
  List<Object?> get props => [
        featuredId,
        featuredTitle,
        featuredImage,
      ];
}

class HomeTrendingBookList extends Equatable {
  const HomeTrendingBookList({
    required this.trendingId,
    required this.trendingTitle,
    required this.trendingImage,
    required this.trendingBookPrice,
    required this.trendingRating,
  });

  final String trendingId;
  final String trendingTitle;
  final String trendingImage;
  final String trendingBookPrice;
  final double trendingRating;

  @override
  List<Object?> get props => [
        trendingId,
        trendingTitle,
        trendingImage,
        trendingBookPrice,
        trendingRating,
      ];
}

class HomeManualBookList extends Equatable {
  final String manualId;
  final String manualTitle;
  final String manualImage;
  final String manualBookPrice;
  final double manualRating;

  const HomeManualBookList({
    required this.manualId,
    required this.manualTitle,
    required this.manualImage,
    required this.manualBookPrice,
    required this.manualRating,
  });

  @override
  List<Object?> get props => [
        manualId,
        manualId,
        manualImage,
        manualBookPrice,
        manualRating,
      ];
}

class HomeSubCategoryBookList extends Equatable {
  const HomeSubCategoryBookList({
    required this.subCategoryId,
    required this.subCategoryTitle,
    required this.subCategoryImage,
  });

  final String subCategoryId;
  final String subCategoryTitle;
  final String subCategoryImage;

  @override
  List<Object?> get props => [
        subCategoryId,
        subCategoryTitle,
        subCategoryImage,
      ];
}

class HomeWorkbookList extends Equatable {
  const HomeWorkbookList({
    required this.workbookId,
    required this.workbookTitle,
    required this.workbookImage,
    required this.workbookPrice,
    required this.workbookRating,
  });

  final String workbookId;
  final String workbookTitle;
  final String workbookImage;
  final String workbookPrice;
  final double workbookRating;

  @override
  List<Object?> get props => [
        workbookId,
        workbookTitle,
        workbookImage,
        workbookPrice,
        workbookRating,
      ];
}
