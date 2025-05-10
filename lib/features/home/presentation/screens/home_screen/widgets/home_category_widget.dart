import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:foursquare_ebbok_app/features/categories/presentation/cubits/categories_cubit.dart';
import 'package:shimmer/shimmer.dart';

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


class HomeCategoryShimmer extends StatelessWidget {
  const HomeCategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title Row Shimmer
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 150,
                height: 24,
                color: Colors.white,
              ),
              Container(
                width: 24,
                height: 24,
                color: Colors.white,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Horizontal List Shimmer
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(4, (index) => _buildCategoryCardShimmer(context)),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCardShimmer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Stack(
          children: [
            // Main Card Container
            Container(
              width: 185,
              height: 121,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            ),

            // Gradient Overlay (simplified for shimmer)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Colors.white,
                ),
              ),
            ),

            // Category Name Placeholder
            Positioned(
              bottom: 10,
              left: 10,
              child: Container(
                width: 120,
                height: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}