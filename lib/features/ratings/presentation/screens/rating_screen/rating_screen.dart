import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';
import 'package:foursquare_ebbok_app/features/ratings/presentation/cubits/ratings_cubit.dart';
import 'package:foursquare_ebbok_app/features/ratings/presentation/screens/model/rating_screen_model.dart';
import 'package:shimmer/shimmer.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key, required this.bookId});

  final String bookId;

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RatingsCubit>().getBookRatingsEvent(widget.bookId);
  }

  @override
  Widget build(BuildContext context) {
    // final ratingValues = ['All', '1', '2', '3', '4', '5'];
    return BlocBuilder<RatingsCubit, RatingsState>(
      builder: (context, state) {
        final model = state.model;
        final screenModel = model.screenModel;

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

        return screenModel.loading
            ? RatingScreenShimmer()
            : Scaffold(
                backgroundColor: Color(0xFFFDFDFD),
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
                                  onTap: () => context
                                      .read<RatingsCubit>()
                                      .ratingsScreenEvent(
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
                            child: Image.asset(
                              "assets/images/no_rating.png",
                              fit: BoxFit.cover,
                            ),
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

class RatingScreenShimmer extends StatelessWidget {
  const RatingScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 20,
            width: 180,
            color: Colors.grey,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            // Rating Filter Shimmer Boxes
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(6, (index) => _shimmerRatingBox()),
              ),
            ),
            VSpace(20),
            // Placeholder for ratings
            Expanded(
              child: ListView.separated(
                itemCount: 5,
                separatorBuilder: (_, __) => VSpace(20),
                itemBuilder: (_, __) => _shimmerRatingCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shimmerRatingBox() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(Icons.star, color: Colors.white),
            HSpace(5),
            Container(
              height: 16,
              width: 20,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _shimmerRatingCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Profile Image
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              HSpace(10),
              // Name and Date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 15,
                      width: 100,
                      color: Colors.white,
                    ),
                    VSpace(4),
                    Container(
                      height: 10,
                      width: 60,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              // Rating Box
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.white, size: 16),
                    HSpace(5),
                    Container(height: 12, width: 12, color: Colors.white),
                  ],
                ),
              ),
              HSpace(10),
              Icon(Icons.more_vert_outlined, size: 30),
            ],
          ),
          VSpace(10),
          Container(
            height: 40,
            width: double.infinity,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
