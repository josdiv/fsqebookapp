import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foursquare_ebbok_app/core/helper/navigate_to_book_details.dart';
import 'package:foursquare_ebbok_app/features/home/presentation/cubits/home_cubit.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../core/misc/spacer.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../profile/presentation/cubits/profile_cubit.dart';
import '../../../../../status/presentation/cubits/status_cubit.dart';
import '../../../../domain/entity/home_entity.dart';

class HomeTrendingWidget extends StatelessWidget {
  const HomeTrendingWidget({
    super.key,
    required this.trendingBookTitle,
    required this.trendingBookList,
  });

  final String trendingBookTitle;
  final List<HomeTrendingBookList> trendingBookList;

  @override
  Widget build(BuildContext context) {
    final isUserLoggedIn =
        context.read<StatusCubit>().state.model.isUserLoggedIn;
    final profile =
        context.read<ProfileCubit>().state.model.networkModel.profile;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final areAllBooksFree = state.model.areAllBooksFree;

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  trendingBookTitle,
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blueColor,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_outlined,
                  color: AppColors.orangeColor,
                )
              ],
            ),
            VSpace(10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: trendingBookList
                    .map(
                      (item) => GestureDetector(
                        onTap: () => toBookDetails(
                          data: {
                            'id': item.trendingId,
                            'userId': isUserLoggedIn ? profile.userId : '',
                          },
                          context: context,
                        ),
                        child: homeCardWidget(
                          title: item.trendingTitle,
                          url: item.trendingImage,
                          bookPrice:
                              areAllBooksFree ? 'Free' : item.trendingBookPrice,
                          rating: item.trendingRating,
                          context: context,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget homeCardWidget({
    required String title,
    required String url,
    required String bookPrice,
    required double rating,
    required BuildContext context,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.5,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2.5,
            height: 250,
            margin: EdgeInsets.only(right: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(10),
              ),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: (context, url) => Image.asset(
                      'assets/images/book_placeholder.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/book_placeholder.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.orangeColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(5)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset('assets/icons/premium.svg'),
                        HSpace(4),
                        Text(
                          bookPrice.toLowerCase() == 'free'
                              ? 'Free'
                              : 'Premium',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.blueColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'by FourSquare Gospel Church',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF424242),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                VSpace(4),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 17,
                      color: AppColors.purpleColor,
                    ),
                    Text(
                      '$rating',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Spacer(),
                    Text(
                      bookPrice,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeTrendingShimmer extends StatelessWidget {
  const HomeTrendingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title Row Shimmer
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 150,
                height: 24,
                color: Colors.white,
              ),
              Container(
                width: 24,
                height: 24,
                color: Colors.white,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Horizontal List Shimmer
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                List.generate(4, (index) => _buildBookCardShimmer(context)),
          ),
        ),
      ],
    );
  }

  Widget _buildBookCardShimmer(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.5,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container with Premium Badge
            Container(
              width: MediaQuery.of(context).size.width / 2.5,
              height: 250,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Stack(
                children: [
                  // Premium Badge Shimmer
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(5)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 40,
                            height: 12,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Text Content Shimmer
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    height: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 120,
                    height: 12,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: 17,
                        height: 17,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Container(
                        width: 20,
                        height: 14,
                        color: Colors.white,
                      ),
                      const Spacer(),
                      Container(
                        width: 40,
                        height: 14,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
