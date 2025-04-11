import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/screens/book_details_screen/book_details_screen.dart';
import 'package:foursquare_ebbok_app/features/latest/presentation/cubits/latest_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'latest_card_widget.dart';

class LatestGridWidget extends StatefulWidget {
  const LatestGridWidget({super.key});

  @override
  State<LatestGridWidget> createState() => _LatestGridWidgetState();
}

class _LatestGridWidgetState extends State<LatestGridWidget> {
  @override
  void initState() {
    super.initState();
    print("called");
    context.read<LatestCubit>().getLatestBooksEvent();
  }

  @override
  void dispose() {
    super.dispose();
    Loader.hide();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LatestCubit, LatestState>(
      listener: (context, state) {
        if (state is LatestBooksError) {
          Loader.hide();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
          print(state.error);
          print(state.isLoaded);
        }

        if (state is LatestBooksLoading) {
          print("loading");
          Loader.show(
            context,
            progressIndicator: LoadingAnimationWidget.threeRotatingDots(
              color: AppColors.purpleColor,
              size: 40,
            ),
          );
        }

        if (state is LatestBooksLoaded) {
          Loader.hide();
        }
      },
      builder: (context, state) {
        // if (state is LatestBooksLoading && !state.isLoaded) {
        //   Loader.show(
        //     context,
        //     progressIndicator: LoadingAnimationWidget.threeRotatingDots(
        //       color: AppColors.purpleColor,
        //       size: 40,
        //     ),
        //   );
        // }
        return state is LatestBooksLoaded
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  childAspectRatio: (MediaQuery.of(context).size.width / 2) /
                      370, // Adjust to your needs
                ),
                itemCount: state.latestBooks.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    // onTap: () => Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const BookDetailsScreen(),
                    //   ),
                    // ),
                    child: LatestCardWidget(
                      title: state.latestBooks[index].bookTitle,
                      url: state.latestBooks[index].bookImage,
                      rating: (state.latestBooks[index].ratingCount).toDouble(),
                      price: state.latestBooks[index].bookPrice,
                    ),
                  );
                },
              )
            : SizedBox();
      },
    );
  }
}
