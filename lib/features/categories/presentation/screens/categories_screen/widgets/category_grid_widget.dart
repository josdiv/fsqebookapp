import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:foursquare_ebbok_app/core/helper/common_loader.dart';
import 'package:foursquare_ebbok_app/features/bible_study/presentation/screens/bible_study_screen/bible_study_screen.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/entity/category_entity.dart';
import 'package:foursquare_ebbok_app/features/categories/presentation/cubits/categories_cubit.dart';
import 'package:foursquare_ebbok_app/features/categories/presentation/screens/sub_category_screen/sub_category_screen.dart';

import 'category_card.dart';

class CategoryGridWidget extends StatefulWidget {
  const CategoryGridWidget({super.key, required this.categories});

  final List<CategoryEntity> categories;

  @override
  State<CategoryGridWidget> createState() => _CategoryGridWidgetState();
}

class _CategoryGridWidgetState extends State<CategoryGridWidget> {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listener: (context, state) {
        print("My State: $state");
        if (state is SubCategoriesLoadingState) {
          // commonLoader(context);
          print("Loading");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SubCategoryScreen(),
            ),
          );
        }

        if (state is SubCategoriesErrorState) {
          Loader.hide();
        }

        if (state is SubCategoriesLoadedState) {
          print("Loaded");
          Loader.hide();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SubCategoryScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        print(state);
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5, // Adjust to your needs
          ),
          itemCount: widget.categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => context
                  .read<CategoriesCubit>()
                  .getSubCategoriesEvent(widget.categories[index].categoryId),
              child: CategoryCard(
                url: widget.categories[index].categoryImage,
                name: widget.categories[index].categoryName,
              ),
            );
          },
        );
      },
    );
  }
}
