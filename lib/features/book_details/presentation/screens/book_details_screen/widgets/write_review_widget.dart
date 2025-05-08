import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/misc/spacer.dart';
import '../../../../../../core/theme/app_colors.dart';

class WriteReviewWidget extends StatelessWidget {
  const WriteReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
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
    );
  }
}