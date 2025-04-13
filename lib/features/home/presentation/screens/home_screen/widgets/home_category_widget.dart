import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:foursquare_ebbok_app/features/categories/presentation/cubits/categories_cubit.dart';

import '../../../../../../core/helper/common_loader.dart';
import '../../../../../../core/misc/spacer.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../categories/presentation/screens/categories_screen/widgets/category_card.dart';

import '../../../../../categories/presentation/screens/sub_category_screen/sub_category_screen.dart';
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
    return BlocListener<CategoriesCubit, CategoriesState>(
      listener: (context, state) {
        final model = state.model;
        final model2 = model.model2;
        final event = context.read<CategoriesCubit>();

        if (model2.loading) {
          commonLoader(context);
        }

        if (model2.hasError) {
          Loader.hide();
          showSnackBar(context, model2.error);
          event.categoriesScreenEvent(
            model.copyWith(
              model2: model2.copyWith(
                error: '',
              ),
            ),
          );
        }

        if (model2.loaded) {
          Loader.hide();
          event.categoriesScreenEvent(
            model.copyWith(
              model2: model2.copyWith(
                loaded: false,
              ),
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SubCategoryScreen(),
            ),
          );
        }
      },
      child: Column(
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
                        onTap: () => context
                            .read<CategoriesCubit>()
                            .getSubCategoriesEvent(
                              id: item.subCategoryId,
                              categoryName: item.subCategoryTitle,
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
      ),
    );
  }
}
