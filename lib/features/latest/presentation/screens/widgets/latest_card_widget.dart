import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/misc/spacer.dart';
import '../../../../../core/theme/app_colors.dart';

class LatestCardWidget extends StatelessWidget {
  const LatestCardWidget({
    super.key,
    required this.title,
    required this.url,
    required this.rating,
    required this.price,
  });

  final String title;
  final String url;
  final String price;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
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
                width: MediaQuery.of(context).size.width,
                height: 250,
                fit: BoxFit.cover,
                placeholder: (context, url) => Image.asset(
                  'assets/images/book_placeholder.png',
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/book_placeholder.png',
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.orangeColor,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(5),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset('assets/icons/premium.svg'),
                    const HSpace(4),
                    Text(
                      price.toLowerCase() == 'free' ? 'Free' : 'Premium',
                      style: const TextStyle(
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
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 2),
            const Text(
              'by FourSquare Gospel Church',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF424242),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.star,
                  size: 18,
                  color: AppColors.purpleColor,
                ),
                Text(rating.toStringAsFixed(2)),
                const Spacer(),
                Text(price),
              ],
            ),
          ],
        ),
      ],
    );
  }
}


class LatestCardShimmer extends StatelessWidget {
  const LatestCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          // Image Placeholder with top-left badge
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(10),
            ),
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  color: Colors.white,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  child: Container(
                    width: 60,
                    height: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Container(
                height: 16,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 4),
                color: Colors.white,
              ),
              // Subtitle
              Container(
                height: 14,
                width: 180,
                margin: const EdgeInsets.only(bottom: 4),
                color: Colors.white,
              ),
              // Row for star, rating and price
              Row(
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    height: 14,
                    width: 30,
                    color: Colors.white,
                  ),
                  const Spacer(),
                  Container(
                    height: 14,
                    width: 40,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
