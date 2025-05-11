import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../core/misc/spacer.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/ui/widgets/default_button.dart';
import '../../../../../profile/presentation/cubits/profile_cubit.dart';
import '../../../cubits/book_details_cubit.dart';

class WriteReviewWidget extends StatelessWidget {
  const WriteReviewWidget({super.key});



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookDetailsCubit, BookDetailsState>(
      builder: (context, state) {
        final userId = context
            .read<ProfileCubit>()
            .state
            .model
            .networkModel
            .profile
            .userId;
        final book = state.model.getBookDetailsModel.entity;

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
                customFilledIcon: Icons.star_rounded,
                customHalfFilledIcon: Icons.star_half_rounded,
                customEmptyIcon: Icons.star_border_purple500_rounded,
                starSize: 40.0,
                animationDuration: Duration(milliseconds: 300),
                animationCurve: Curves.easeInOut,
                // readOnly: true,
              ),
              VSpace(4),
              InkWell(
                onTap: () => showWriteReviewBottomSheet(
                  context: context,
                  userId: userId,
                  bookId: book.bookId,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.orangeColor, width: 2),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "Write a Review",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.orangeColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

void showWriteReviewBottomSheet({
  required BuildContext context,
  required String userId,
  required String bookId,
}) {
  final formKey = GlobalKey<FormState>();
  final reviewController = TextEditingController();
  int rating = 0;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      final screenHeight = MediaQuery.of(context).size.height;
      return BlocBuilder<BookDetailsCubit, BookDetailsState>(
        builder: (context, state) {
          final model = state.model;
          final writeReviewModel = model.writeReviewModel;

          return GestureDetector(
            onTap: () {
              FocusScope.of(context)
                  .unfocus(); // ✅ Dismiss keyboard on tap outside
            },
            behavior: HitTestBehavior.opaque,
            // ensures it catches taps on empty space
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom * .8,
              ),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: screenHeight * 0.5, // 50% of screen
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Text(
                            'Book Review',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.blueColor),
                          ),
                        ),
                        VSpace(5),
                        Center(
                          child: Text(
                            'How likely are you to recommend moving it to a '
                            'friend?(1-low, 5-high)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        VSpace(5),
                        Align(
                          child: AnimatedRatingStars(
                            // key: ValueKey(ratings),
                            // initialRating: ratings.toDouble(),
                            minRating: 0.0,
                            maxRating: 5.0,
                            filledColor: AppColors.purpleColor,
                            emptyColor: Colors.grey,
                            filledIcon: Icons.star_rounded,
                            halfFilledIcon: Icons.star_half,
                            emptyIcon: Icons.star_border,
                            onChanged: (double x) {
                              rating = x.toInt();
                            },
                            displayRatingValue: true,
                            interactiveTooltips: true,
                            customFilledIcon: Icons.star_rounded,
                            customHalfFilledIcon: Icons.star_half_rounded,
                            customEmptyIcon:
                                Icons.star_border_purple500_rounded,
                            starSize: 30.0,
                            animationDuration: Duration(milliseconds: 300),
                            animationCurve: Curves.easeInOut,
                            // readOnly: true,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Write Your Review',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blueColor),
                        ),
                        VSpace(16),
                        Form(
                          key: formKey,
                          child: TextFormField(
                            controller: reviewController,
                            maxLines: 3,
                            // autofocus: true,
                            decoration: InputDecoration(
                              labelText: 'Your review here',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignLabelWithHint: true,
                              suffixIcon: reviewController.text.isNotEmpty
                                  ? IconButton(
                                      icon: Icon(Icons.clear),
                                      onPressed: () {
                                        reviewController.clear();
                                        if (formKey.currentState != null) {
                                          formKey.currentState!.validate();
                                        }
                                      },
                                    )
                                  : null,
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter a report';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              if (formKey.currentState != null) {
                                formKey.currentState!.validate();
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: DefaultButton(
                                  backgroundColor: Colors.orange,
                                  text: 'MAYBE LATER',
                                  textColor: AppColors.orangeColor,
                                ),
                              ),
                            ),
                            HSpace(10),
                            Expanded(
                              child: DefaultButton(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    // Process the report here
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   SnackBar(content: Text('Report submitted')),
                                    // );
                                    context.read<BookDetailsCubit>().writeReviewEvent({
                                      'userId': userId,
                                      'bookId': bookId,
                                      'reviews': reviewController.text.trim(),
                                      'bookRating': rating.toString(),
                                    });
                                  }
                                },
                                opacity: true,
                                loading: writeReviewModel.loading,
                                text: 'SUBMIT',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

class WriteReviewShimmerWidget extends StatelessWidget {
  const WriteReviewShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 20,
              width: 120,
              margin: EdgeInsets.symmetric(vertical: 8),
              color: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Icon(
                    Icons.star,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 10),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Text(
                "          ", // Empty space to mimic button text
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}