import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/features/categories/presentation/cubits/categories_cubit.dart';

import '../../../../../categories/presentation/screens/categories_screen/widgets/category_card.dart';

class SubCategoryGridWidget extends StatelessWidget {
  const SubCategoryGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return state is SubCategoriesLoadedState ? GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5, // Adjust to your needs
          ),
          itemCount: state.subCategories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: CategoryCard(
                url: state.subCategories[index].subcategoryImage,
                name: state.subCategories[index].subcategoryName,
              ),
            );
          },
        ) : SizedBox();
      },
    );
  }
}
