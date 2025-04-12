import 'package:flutter/material.dart';

import '../../../../../../core/helper/navigate_to_book_details.dart';
import '../../../../../../core/misc/spacer.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../categories/presentation/screens/categories_screen/widgets/category_card.dart';

import '../../../../domain/entity/home_entity.dart';

class HomeCategoryWidget extends StatelessWidget {
  const HomeCategoryWidget({
    super.key,
    required this.subcategoryBookTitle,
    required this.subCategoryBookList,
  });

  final String subcategoryBookTitle;
  final List<HomeSubCategoryBookList> subCategoryBookList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              subcategoryBookTitle,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: AppColors.blueColor,
              ),
            ),
            Icon(
              Icons.arrow_forward_outlined,
              color: AppColors.orangeColor,
            ),
          ],
        ),
        VSpace(10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: subCategoryBookList
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: GestureDetector(
                      onTap: () => toBookDetails(
                        id: item.subCategoryId,
                        context: context,
                      ),
                      child: CategoryCard(
                        url: item.subCategoryImage,
                        name: item.subCategoryTitle,
                        width: 185,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
