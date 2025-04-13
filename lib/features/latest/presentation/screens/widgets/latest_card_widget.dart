import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
        Container(
          width: MediaQuery.of(context).size.width,
          height: 250,
          margin: EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(10),
            ),
            image: DecorationImage(
              image: NetworkImage(url),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.topLeft,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: BoxDecoration(
                color: AppColors.orangeColor,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(5))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('assets/icons/premium.svg'),
                HSpace(4),
                Text(
                  "Premium",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
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
            Text(
              'by FourSquare Gospel Church',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF424242),
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  size: 18,
                  color: AppColors.purpleColor,
                ),
                Text(rating.toStringAsFixed(2)),
                Spacer(),
                Text(price),
              ],
            )
          ],
        ),
      ],
    );
  }
}
