import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/cubits/book_details_cubit.dart';

class RatingsAndReview extends StatelessWidget {
  const RatingsAndReview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookDetailsCubit, BookDetailsState>(
      builder: (context, state) {
        final ratings = state is BookDetailsLoadedState ? state.entity.bookAverageRating : 0;
        final ratingCount = state is BookDetailsLoadedState ? state.entity.bookReviewCount : 0;

        return Column(
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
                Icon(
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
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.orangeColor, width: 2),
                      borderRadius: BorderRadius.circular(20)
                    ),
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
        );
      },
    );
  }
}
