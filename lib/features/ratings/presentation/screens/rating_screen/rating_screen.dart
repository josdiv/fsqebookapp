import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';
import 'package:foursquare_ebbok_app/features/ratings/presentation/cubits/ratings_cubit.dart';
import 'package:foursquare_ebbok_app/features/ratings/presentation/screens/model/rating_screen_model.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final ratingValues = ['All', '1', '2', '3', '4', '5'];
    return BlocBuilder<RatingsCubit, RatingsState>(
      builder: (context, state) {
        final model = state.model;
        final screenModel = model.screenModel;
        // final ratings = screenModel.ratings;
        //
        // print(screenModel.getRatings5);

        final filteredRatings = () {
          switch (screenModel.currentRatingValue) {
            case RatingsValue.zero:
              return screenModel.getRatings0;
            case RatingsValue.one:
              return screenModel.getRatings1;
            case RatingsValue.two:
              return screenModel.getRatings2;
            case RatingsValue.three:
              return screenModel.getRatings3;
            case RatingsValue.four:
              return screenModel.getRatings4;
            case RatingsValue.five:
              return screenModel.getRatings5;
            case RatingsValue.all:
              return screenModel.ratings;
          }
        }();


        final ratingValues = [
          RatingBoxEntity(
            value: 'All',
            ratingsValue: RatingsValue.all,
            screenModel: screenModel.selectAll(),
          ),
          // RatingBoxEntity(
          //   value: '0',
          //   ratingsValue: RatingsValue.zero,
          //   screenModel: screenModel.selectZero(),
          // ),
          RatingBoxEntity(
            value: '1',
            ratingsValue: RatingsValue.one,
            screenModel: screenModel.selectOne(),
          ),
          RatingBoxEntity(
            value: '2',
            ratingsValue: RatingsValue.two,
            screenModel: screenModel.selectTwo(),
          ),
          RatingBoxEntity(
            value: '3',
            ratingsValue: RatingsValue.three,
            screenModel: screenModel.selectThree(),
          ),
          RatingBoxEntity(
            value: '4',
            ratingsValue: RatingsValue.four,
            screenModel: screenModel.selectFour(),
          ),
          RatingBoxEntity(
            value: '5',
            ratingsValue: RatingsValue.five,
            screenModel: screenModel.selectFive(),
          ),
        ];

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: false,
            title: Text(
              'Ratings and Reviews',
              style: TextStyle(
                color: AppColors.blueColor,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ratingValues
                        .map(
                          (value) => ratingBoxWidget(
                            value: value.value,
                            selected: value.ratingsValue ==
                                screenModel.currentRatingValue,
                            onTap: () =>
                                context.read<RatingsCubit>().ratingsScreenEvent(
                                      model.copyWith(
                                        screenModel: value.screenModel,
                                      ),
                                    ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                VSpace(20),
                filteredRatings.isEmpty
                    ? Center(
                        child: Text(
                            "This book has no ratings.\nBe the first to rate this book"),
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: filteredRatings
                                .map(
                                  (rating) => RatingsCardWidget(
                                    url: rating.profileImage,
                                    value: rating.rating,
                                    subtitle: rating.ratingDate,
                                    title: rating.profileName,
                                    review: rating.review,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget ratingBoxWidget({
  required String value,
  bool selected = false,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.blueColor, width: 2),
        color: selected ? AppColors.blueColor : Colors.white,
      ),
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: selected ? Colors.white : AppColors.blueColor,
          ),
          HSpace(5),
          Text(
            value,
            style: TextStyle(
              fontSize: 19,
              color: selected ? Colors.white : AppColors.blueColor,
            ),
          ),
        ],
      ),
    ),
  );
}

class RatingBoxEntity extends Equatable {
  const RatingBoxEntity({
    required this.value,
    required this.ratingsValue,
    required this.screenModel,
  });

  final String value;
  final RatingsValue ratingsValue;
  final RatingScreenModel screenModel;

  @override
  List<Object?> get props => [value, ratingsValue, screenModel];
}

class RatingsCardWidget extends StatelessWidget {
  const RatingsCardWidget({
    super.key,
    required this.url,
    required this.value,
    required this.subtitle,
    required this.title,
    required this.review,
  });

  final String url;
  final String value;
  final String title;
  final String subtitle;
  final String review;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(url),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              HSpace(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0xFF4E4B66),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    VSpace(4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Color(0xFF424242),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              // Spacer(),
              ratingBoxWidget(value: value),
              // HSpace(10),
              Icon(
                Icons.more_vert_outlined,
                size: 30,
              )
            ],
          ),
          VSpace(10),
          Text(
            review,
            style: TextStyle(
              color: Color(0xFF424242).withOpacity(0.6),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
