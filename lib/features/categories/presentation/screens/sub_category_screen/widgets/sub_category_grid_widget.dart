import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:foursquare_ebbok_app/features/categories/presentation/cubits/categories_cubit.dart';
import 'package:foursquare_ebbok_app/features/categories/presentation/screens/sub_category_details_screen/sub_category_details_screen.dart';

import '../../../../../../core/helper/common_loader.dart';
import '../../../../../categories/presentation/screens/categories_screen/widgets/category_card.dart';

class SubCategoryGridWidget extends StatelessWidget {
  const SubCategoryGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listener: (context, state) {
        final model = state.model;
        final model3 = model.model3;
        final event = context.read<CategoriesCubit>();

        if (model3.loading) {
          commonLoader(context);
        }

        if (model3.hasError) {
          Loader.hide();
          showSnackBar(context, model3.error);
          event.categoriesScreenEvent(
            model.copyWith(
              model3: model3.copyWith(
                error: '',
              ),
            ),
          );
        }

        if (model3.loaded) {
          Loader.hide();
          event.categoriesScreenEvent(
            model.copyWith(
              model3: model3.copyWith(
                loaded: false,
              ),
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SubCategoryDetailsScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        final model = state.model;
        final model2 = model.model2;
        final event = context.read<CategoriesCubit>();

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5, // Adjust to your needs
          ),
          itemCount: model2.subCategories.length,
          itemBuilder: (context, index) {
            final subCategory = model2.subCategories[index];
            return GestureDetector(
              onTap: () => event.getSubCategoriesDetailsEvent(
                id: subCategory.subcategoryId,
                subCategoryName: subCategory.subcategoryName,
              ),
              child: CategoryCard(
                url: subCategory.subcategoryImage,
                name: subCategory.subcategoryName,
              ),
            );
          },
        );
      },
    );
  }
}
