import 'package:foursquare_ebbok_app/features/home/domain/entity/home_entity.dart';

import '../../../../core/utils/typedefs/typedefs.dart';

class HomeEntityModel extends HomeEntity {
  const HomeEntityModel({
    required super.featuredBookTitle,
    required super.featuredBookList,
    required super.trendingBookTitle,
    required super.trendingBookList,
    required super.manualBookTitle,
    required super.manualBookList,
    required super.subcategoryBookTitle,
    required super.subCategoryBookList,
    required super.workbookTitle,
    required super.workbookList,
  });

  factory HomeEntityModel.fromJson(Map<String, dynamic> json) {
    return HomeEntityModel(
      featuredBookTitle: json["featuredBookTitle"],
      featuredBookList: List.of(
        json["featuredBookList"],
      )
          .map(
            (i) => HomeFeaturedBookListModel.fromJson(i as DataMap),
          )
          .toList(),
      trendingBookTitle: json["trendingBookTitle"],
      trendingBookList: List.of(
        json["trendingBookList"],
      )
          .map(
            (i) => HomeTrendingBookListModel.fromJson(i as DataMap),
          )
          .toList(),
      manualBookTitle: json["manualBookTitle"],
      manualBookList: List.of(
        json["manualBookList"],
      )
          .map(
            (i) => HomeManualBookListModel.fromJson(i as DataMap),
          )
          .toList(),
      subcategoryBookTitle: json["subcategoryBookTitle"],
      subCategoryBookList: List.of(
        json["subCategoryBookList"],
      )
          .map(
            (i) => HomeSubCategoryBookListModel.fromJson(i as DataMap),
          )
          .toList(),
      workbookTitle: json["workbookTitle"],
      workbookList: List.of(json["workbookList"] as List<dynamic>)
          .map(
            (i) => HomeWorkbookListModel.fromJson(i as DataMap),
          )
          .toList(),
    );
  }
}

class HomeFeaturedBookListModel extends HomeFeaturedBookList {
  const HomeFeaturedBookListModel({
    required super.featuredId,
    required super.featuredTitle,
    required super.featuredImage,
  });

  factory HomeFeaturedBookListModel.fromJson(Map<String, dynamic> json) {
    return HomeFeaturedBookListModel(
      featuredId: json["featuredId"].toString(),
      featuredTitle: json["featuredTitle"],
      featuredImage: json["featuredImage"],
    );
  }
}

class HomeTrendingBookListModel extends HomeTrendingBookList {
  const HomeTrendingBookListModel({
    required super.trendingId,
    required super.trendingTitle,
    required super.trendingImage,
    required super.trendingBookPrice,
    required super.trendingRating,
  });

  factory HomeTrendingBookListModel.fromJson(Map<String, dynamic> json) {
    return HomeTrendingBookListModel(
      trendingId: json["trendingId"].toString(),
      trendingTitle: json["trendingTitle"],
      trendingImage: json["trendingImage"],
      trendingBookPrice: json["trendingBookPrice"],
      trendingRating: (json["trendingRating"] as num).toDouble(),
    );
  }
//
}

class HomeManualBookListModel extends HomeManualBookList {
  const HomeManualBookListModel({
    required super.manualId,
    required super.manualTitle,
    required super.manualImage,
    required super.manualBookPrice,
    required super.manualRating,
  });

  factory HomeManualBookListModel.fromJson(Map<String, dynamic> json) {
    return HomeManualBookListModel(
      manualId: json["manualId"].toString(),
      manualTitle: json["manualTitle"],
      manualImage: json["manualImage"],
      manualBookPrice: json["manualBookPrice"],
      manualRating: (json["manualRating"] as num).toDouble(),
    );
  }
//
}

class HomeSubCategoryBookListModel extends HomeSubCategoryBookList {
  const HomeSubCategoryBookListModel({
    required super.subCategoryId,
    required super.subCategoryTitle,
    required super.subCategoryImage,
  });

  factory HomeSubCategoryBookListModel.fromJson(Map<String, dynamic> json) {
    return HomeSubCategoryBookListModel(
      subCategoryId: json["subCategoryId"].toString(),
      subCategoryTitle: json["subCategoryTitle"],
      subCategoryImage: json["subCategoryImage"],
    );
  }
}

class HomeWorkbookListModel extends HomeWorkbookList {
  const HomeWorkbookListModel({
    required super.workbookId,
    required super.workbookTitle,
    required super.workbookImage,
    required super.workbookPrice,
    required super.workbookRating,
  });

  factory HomeWorkbookListModel.fromJson(Map<String, dynamic> json) {
    return HomeWorkbookListModel(
      workbookId: json["workbookId"].toString(),
      workbookTitle: json["workbookTitle"],
      workbookImage: json["workbookImage"],
      workbookPrice: json["workbookPrice"],
      workbookRating: (json["workbookRating"] as num).toDouble(),
    );
  }
}
