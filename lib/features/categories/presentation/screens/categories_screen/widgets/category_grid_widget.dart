import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:foursquare_ebbok_app/core/helper/common_loader.dart';
import 'package:foursquare_ebbok_app/features/categories/presentation/cubits/categories_cubit.dart';
import 'package:foursquare_ebbok_app/features/categories/presentation/screens/sub_category_screen/sub_category_screen.dart';

import 'category_card.dart';

class CategoryGridWidget extends StatefulWidget {
  const CategoryGridWidget({super.key});

  @override
  State<CategoryGridWidget> createState() => _CategoryGridWidgetState();
}

class _CategoryGridWidgetState extends State<CategoryGridWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesState>(
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
      builder: (context, state) {
        final model = state.model;
        final model1 = model.model1;
        final event = context.read<CategoriesCubit>();
        final loading = model1.newLoading;

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5, // Adjust to your needs
          ),
          itemCount: loading ? 6 : model1.categories.length,
          itemBuilder: (context, index) {
            if (loading) {
              return const CategoryCardShimmer();
            }

            final category = model1.categories[index];
            return GestureDetector(
              onTap: () => event.getSubCategoriesEvent(
                id: category.categoryId,
                categoryName: category.categoryName,
              ),
              child: CategoryCard(
                url: category.categoryImage,
                name: category.categoryName,
              ),
            );
          },
        );
      },
    );
  }
}
