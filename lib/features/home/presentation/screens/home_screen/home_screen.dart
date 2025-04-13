import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';
import 'package:foursquare_ebbok_app/features/home/presentation/cubits/home_cubit.dart';
import 'package:foursquare_ebbok_app/features/home/presentation/screens/home_screen/widgets/home_category_widget.dart';
import 'package:foursquare_ebbok_app/features/home/presentation/screens/home_screen/widgets/home_feature_widget.dart';
import 'package:foursquare_ebbok_app/features/home/presentation/screens/home_screen/widgets/home_header_widget.dart';
import 'package:foursquare_ebbok_app/features/home/presentation/screens/home_screen/widgets/home_manual_widget.dart';
import 'package:foursquare_ebbok_app/features/home/presentation/screens/home_screen/widgets/home_trending_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final homeData = state.model.homeData;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VSpace(80),
            HomeHeaderWidget(),
            VSpace(20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HomeFeaturedWidget(
                      featuredBookTitle: homeData.featuredBookTitle,
                      featuredBookList: homeData.featuredBookList,
                    ),
                    VSpace(20),
                    HomeTrendingWidget(
                      trendingBookTitle: homeData.featuredBookTitle,
                      trendingBookList: homeData.trendingBookList,
                    ),
                    VSpace(20),
                    HomeManualWidget(
                      manualBookTitle: homeData.manualBookTitle,
                      manualBookList: homeData.manualBookList,
                    ),
                    VSpace(20),
                    HomeCategoryWidget(
                      subcategoryBookTitle: homeData.subcategoryBookTitle,
                      subCategoryBookList: homeData.subCategoryBookList,
                    ),
                    VSpace(20),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
