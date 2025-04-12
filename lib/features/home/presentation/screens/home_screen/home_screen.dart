import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';
import 'package:foursquare_ebbok_app/features/home/presentation/cubits/home_cubit.dart';
import 'package:foursquare_ebbok_app/features/home/presentation/screens/home_screen/widgets/home_category_widget.dart';
import 'package:foursquare_ebbok_app/features/home/presentation/screens/home_screen/widgets/home_feature_widget.dart';
import 'package:foursquare_ebbok_app/features/home/presentation/screens/home_screen/widgets/home_header_widget.dart';
import 'package:foursquare_ebbok_app/features/home/presentation/screens/home_screen/widgets/home_manual_widget.dart';
import 'package:foursquare_ebbok_app/features/home/presentation/screens/home_screen/widgets/home_trending_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getDashboardDataEvent();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   Loader.hide();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeDataLoaded) {
          Loader.hide();
        }

        if (state is HomeDataError && !state.loaded) {
          Loader.hide();
        }
      },
      builder: (context, state) {
        if (state is HomeDataLoading && !state.loaded) {
          Loader.show(
            context,
            progressIndicator: LoadingAnimationWidget.threeArchedCircle(
              color: AppColors.purpleColor,
              size: 40,
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VSpace(80),
            HomeHeaderWidget(),
            VSpace(20),
            if (state is HomeDataError)
              Center(
                child: Text(state.error),
              ),
            if (state is HomeDataLoaded)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      HomeFeaturedWidget(
                        featuredBookTitle: state.entity.featuredBookTitle,
                        featuredBookList: state.entity.featuredBookList,
                      ),
                      VSpace(20),
                      HomeTrendingWidget(
                        trendingBookTitle: state.entity.featuredBookTitle,
                        trendingBookList: state.entity.trendingBookList,
                      ),
                      VSpace(20),
                      HomeManualWidget(
                        manualBookTitle: state.entity.manualBookTitle,
                        manualBookList: state.entity.manualBookList,
                      ),
                      VSpace(20),
                      HomeCategoryWidget(
                        subcategoryBookTitle: state.entity.subcategoryBookTitle,
                        subCategoryBookList: state.entity.subCategoryBookList,
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
