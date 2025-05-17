import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/core/helper/common_loader.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/cubits/book_details_cubit.dart';
import 'package:foursquare_ebbok_app/features/ratings/presentation/cubits/ratings_cubit.dart';
import 'package:foursquare_ebbok_app/features/ratings/presentation/screens/model/rating_screen_model.dart';
import 'package:foursquare_ebbok_app/features/ratings/presentation/screens/rating_screen/rating_screen.dart';
import 'package:shimmer/shimmer.dart';

class RatingsAndReview extends StatelessWidget {
  const RatingsAndReview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RatingsCubit, RatingsState>(
      listener: (context, state) {
        final model = state.model;
        final screenModel = model.screenModel;
        final event = context.read<RatingsCubit>();

        if (screenModel.hasError) {
          showSnackBar(context, screenModel.error);
          event.ratingsScreenEvent(
            model.copyWith(
              screenModel: screenModel.copyWith(
                error: '',
              ),
            ),
          );
        }

        if (screenModel.loaded) {
          event.ratingsScreenEvent(
            model.copyWith(
              screenModel: screenModel.copyWith(
                loaded: false,
                currentRatingValue: RatingsValue.all,
              ),
            ),
          );

        }
      },
      builder: (context, state) {
        final loading = state.model.screenModel.loading;
        return BlocBuilder<BookDetailsCubit, BookDetailsState>(
          builder: (context, state) {
            final model = state.model;
            final getBookDetailsModel = model.getBookDetailsModel;
            final entity = getBookDetailsModel.entity;

            final ratings = entity.bookAverageRating;
            final ratingCount = entity.bookReviewCount;

            return InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RatingScreen(bookId: entity.bookId,),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ratings & Reviews",
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      loading
                          ? buttonLoader(context, color: AppColors.orangeColor)
                          : Icon(
                              Icons.arrow_forward_outlined,
                              color: AppColors.orangeColor,
                            )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "$ratings",
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blueColor,
                        ),
                      ),
                      AnimatedRatingStars(
                        key: ValueKey(ratings),
                        initialRating: ratings.toDouble(),
                        minRating: 0.0,
                        maxRating: 5.0,
                        filledColor: AppColors.purpleColor,
                        emptyColor: Colors.grey,
                        filledIcon: Icons.star,
                        halfFilledIcon: Icons.star_half,
                        emptyIcon: Icons.star_border,
                        onChanged: (_) {},
                        displayRatingValue: true,
                        interactiveTooltips: true,
                        customFilledIcon: Icons.star,
                        customHalfFilledIcon: Icons.star_half,
                        customEmptyIcon: Icons.star_border,
                        starSize: 10.0,
                        animationDuration: Duration(milliseconds: 300),
                        animationCurve: Curves.easeInOut,
                        readOnly: true,
                      ),
                      Text(
                        "($ratingCount Reviews)",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class RatingsAndReviewShimmer extends StatelessWidget {
  const RatingsAndReviewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        shimmerBox(height: 24, width: 160),
        const SizedBox(height: 10),
        Row(
          children: [
            shimmerBox(height: 20, width: 30),
            const SizedBox(width: 8),
            Row(
              children: List.generate(
                5,
                    (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: shimmerBox(height: 16, width: 16),
                ),
              ),
            ),
            const SizedBox(width: 8),
            shimmerBox(height: 16, width: 80),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(),
      ],
    );
  }

  Widget shimmerBox({required double height, required double width}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        color: Colors.white,
      ),
    );
  }
}
