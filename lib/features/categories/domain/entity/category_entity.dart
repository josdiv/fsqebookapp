import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  const CategoryEntity({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
  });

  final String categoryId;
  final String categoryName;
  final String categoryImage;

  @override
  List<Object?> get props => [
        categoryId,
        categoryName,
        categoryImage,
      ];
}
