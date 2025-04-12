import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:foursquare_ebbok_app/core/helper/common_loader.dart';
import 'package:foursquare_ebbok_app/core/helper/navigate_to_book_details.dart';
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
          showSnackBar(context, state.error);
        }

        if (state is LatestBooksLoaded) {
          Loader.hide();
          print("Loaded ${state.isLoaded}");
        }

        if (state is LatestBooksLoading && !state.isLoaded) {
          print("loading ${state.isLoaded}");
          commonLoader(context);
        }
      },
      builder: (context, state) {
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

                    onTap: () {
                      print(state.latestBooks[index].bookId);
                      toBookDetails(
                        id: state.latestBooks[index].bookId,
                        context: context,
                      );
                    },
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
