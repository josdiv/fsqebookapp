import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/core/helper/common_loader.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/cubits/book_details_cubit.dart';
import 'package:foursquare_ebbok_app/features/ratings/presentation/cubits/ratings_cubit.dart';
import 'package:foursquare_ebbok_app/features/ratings/presentation/screens/model/rating_screen_model.dart';
import 'package:foursquare_ebbok_app/features/ratings/presentation/screens/rating_screen/rating_screen.dart';

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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RatingScreen(),
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
              onTap: () => context
                  .read<RatingsCubit>()
                  .getBookRatingsEvent(entity.bookId),
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
                  Align(
                    child: Column(
                      children: [
                        Text(
                          "Rate this book",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        AnimatedRatingStars(
                          // key: ValueKey(ratings),
                          // initialRating: ratings.toDouble(),
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
                          starSize: 40.0,
                          animationDuration: Duration(milliseconds: 300),
                          animationCurve: Curves.easeInOut,
                          // readOnly: true,
                        ),
                        VSpace(4),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.orangeColor, width: 2),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "Write a Review",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.orangeColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
