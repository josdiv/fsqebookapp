import 'package:foursquare_ebbok_app/features/categories/domain/entity/sub_category_entity.dart';

import '../../../../core/utils/typedefs/typedefs.dart';

class SubCategoryEntityModel extends SubCategoryEntity {
  const SubCategoryEntityModel({
    required super.subcategoryId,
    required super.subcategoryName,
    required super.subcategoryImage,
  });

  factory SubCategoryEntityModel.fromJson(DataMap json) {
    return SubCategoryEntityModel(
      subcategoryId: json['subcategoryId'] as String,
      subcategoryName: json['subcategoryName'] as String,
      subcategoryImage: json['subcategoryImage'] as String,
    );
  }
}
