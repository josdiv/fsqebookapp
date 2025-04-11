import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foursquare_ebbok_app/core/helper/navigate_to_book_details.dart';

import '../../../../../../core/misc/spacer.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../domain/entity/home_entity.dart';

class HomeFeaturedWidget extends StatelessWidget {
  const HomeFeaturedWidget({
    super.key,
    required this.featuredBookTitle,
    required this.featuredBookList,
  });

  final String featuredBookTitle;
  final List<HomeFeaturedBookList> featuredBookList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            featuredBookTitle,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: AppColors.blueColor,
            ),
          ),
          VSpace(10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: featuredBookList
                  .map(
                    (item) => GestureDetector(
                      onTap: () => toBookDetails(
                        id: item.featuredId,
                        context: context,
                      ),
                      child: featuredCard(
                        title: item.featuredTitle,
                        imageUrl: item.featuredImage,
                        context: context,
                      ),
                    ),
                  )
                  .toList(),
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
          // Distributes space
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
