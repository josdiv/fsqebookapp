import '../../domain/entity/category_entity.dart';

class CategoryEntityModel extends CategoryEntity {
  const CategoryEntityModel({
    required super.categoryId,
    required super.categoryName,
    required super.categoryImage,
  });

  factory CategoryEntityModel.fromJson(Map<String, dynamic> json) {
    return CategoryEntityModel(
      categoryId: json["categoryId"],
      categoryName: json["categoryName"],
      categoryImage: json["categoryImage"],
    );
  }
}
