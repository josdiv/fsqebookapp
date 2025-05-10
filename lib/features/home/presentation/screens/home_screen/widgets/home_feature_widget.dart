import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/core/helper/navigate_to_book_details.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../core/misc/spacer.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../profile/presentation/cubits/profile_cubit.dart';
import '../../../../../status/presentation/cubits/status_cubit.dart';
import '../../../../domain/entity/home_entity.dart';

class HomeFeaturedWidget extends StatefulWidget {
  const HomeFeaturedWidget({
    super.key,
    required this.featuredBookTitle,
    required this.featuredBookList,
  });

  final String featuredBookTitle;
  final List<HomeFeaturedBookList> featuredBookList;

  @override
  State<HomeFeaturedWidget> createState() => _HomeFeaturedWidgetState();
}

class _HomeFeaturedWidgetState extends State<HomeFeaturedWidget> {
  final ScrollController _scrollController = ScrollController();
  Timer? _scrollTimer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _scrollTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (!_scrollController.hasClients) return;

      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      final cardWidth = MediaQuery.of(context).size.width - 40 + 10;

      double targetScroll = currentScroll + cardWidth;

      if (targetScroll >= maxScrollExtent) {
        _scrollController.animateTo(0.0,
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      } else {
        _scrollController.animateTo(targetScroll,
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    });
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUserLoggedIn =
        context.read<StatusCubit>().state.model.isUserLoggedIn;
    final profile =
        context.read<ProfileCubit>().state.model.networkModel.profile;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.featuredBookTitle,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: AppColors.blueColor,
            ),
          ),
          VSpace(10),
          SizedBox(
            height: 200, // adjust as needed
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.featuredBookList.length,
              itemBuilder: (context, index) {
                final item = widget.featuredBookList[index];
                return GestureDetector(
                  onTap: () => toBookDetails(
                    data: {
                      'id': item.featuredId,
                      'userId': isUserLoggedIn ? profile.userId : '',
                    },
                    context: context,
                  ),
                  child: featuredCard(
                    title: item.featuredTitle,
                    imageUrl: item.featuredImage,
                    context: context,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget featuredCard({
    required String title,
    required String imageUrl,
    required BuildContext context,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.yellowColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 0,
                    ),
                  ),
                  VSpace(10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      'Explore Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            HSpace(10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ShimmerHomeFeaturedWidget extends StatelessWidget {
  const ShimmerHomeFeaturedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Shimmer title
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 24,
            width: 150,
            color: Colors.white,
          ),
        ),
        VSpace(10),
        // Horizontal shimmer cards
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              return shimmerCard(context);
            },
          ),
        )
      ],
    );
  }

  Widget shimmerCard(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width - 40;
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: cardWidth,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            // Left text section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    width: 120,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            // Right image section
            Container(
              height: 150,
              width: 100,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}