import 'package:equatable/equatable.dart';

class SubCategoryEntity extends Equatable {
  const SubCategoryEntity({
    required this.subcategoryId,
    required this.subcategoryName,
    required this.subcategoryImage,
  });

  final String subcategoryId;
  final String subcategoryName;
  final String subcategoryImage;

  @override
  List<Object?> get props => [
        subcategoryId,
        subcategoryName,
        subcategoryImage,
      ];
}
