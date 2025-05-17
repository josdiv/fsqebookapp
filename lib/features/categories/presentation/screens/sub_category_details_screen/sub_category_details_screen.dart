import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';
import 'package:foursquare_ebbok_app/features/categories/presentation/cubits/categories_cubit.dart';
import 'package:foursquare_ebbok_app/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:foursquare_ebbok_app/features/status/presentation/cubits/status_cubit.dart';

import '../../../../../core/helper/navigate_to_book_details.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../latest/presentation/screens/widgets/latest_card_widget.dart';

class SubCategoryDetailsScreen extends StatelessWidget {
  const SubCategoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        final name = state.model.model3.subCategoryName;
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.backgroundColor,
            centerTitle: false,
            title: Text(
              name,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: AppColors.blueColor,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                VSpace(20),
                Expanded(
                  child: SubCategoryDetailsGrid(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SubCategoryDetailsGrid extends StatelessWidget {
  const SubCategoryDetailsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        final categories = state.model.model3.subCategoryDetails;
        final isUserLoggedIn =
            context.read<StatusCubit>().state.model.isUserLoggedIn;
        final profile =
            context.read<ProfileCubit>().state.model.networkModel.profile;

        return categories.isEmpty
            ? Center(
                child: Image.asset("assets/images/no_content_3.png"),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 0,
                  childAspectRatio: (MediaQuery.of(context).size.width / 2) /
                      400, // Adjust to your needs
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      toBookDetails(
                        data: {
                          'id': categories[index].bookId,
                          'userId': isUserLoggedIn ? profile.userId : '',
                        },
                        context: context,
                      );
                    },
                    child: LatestCardWidget(
                      title: categories[index].bookTitle,
                      url: categories[index].bookImage,
                      rating: double.parse(categories[index].bookRating),
                      price: categories[index].bookPrice,
                    ),
                  );
                },
              );
      },
    );
  }
}
