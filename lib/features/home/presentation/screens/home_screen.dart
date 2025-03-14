import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';
import 'package:foursquare_ebbok_app/features/categories/presentation/screens/widgets/category_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VSpace(80),
          HomeHeaderWidget(),
          VSpace(20),
          HomeFeaturedWidget(),
          VSpace(20),
          HomeTrendingWidget(),
          VSpace(20),
          HomeManualWidget(),
          VSpace(20),
          HomeCategoryWidget(),
          VSpace(20),
        ],
      ),
    );
  }
}

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              "assets/images/appicon.png",
              height: 50,
            ),
            HSpace(20),
            Text(
              "eBook Store",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: AppColors.blueColor),
            ),
            Spacer(),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.purpleColor.withOpacity(.2)),
              child: Icon(Icons.settings),
            )
          ],
        ),
        VSpace(15),
        SizedBox(
          height: 45,
          child: TextFormField(
            maxLines: null,
            minLines: null,
            expands: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              suffixIcon: Icon(Icons.search),
              filled: true,
              fillColor: AppColors.purpleColor.withOpacity(.2),
              hintText: 'Search here...',
            ),
          ),
        )
      ],
    );
  }
}

class HomeFeaturedWidget extends StatelessWidget {
  const HomeFeaturedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final list = [
      {
        "featuredId": "53",
        "featuredTitle": "House Fellowship Manual 2024",
        "featuredImage":
            "https://fsqebookapp.com.ng/ebook_app/upload/cover_unity_spirit_house_fellowship.png"
      },
      {
        "featuredId": "54",
        "featuredTitle": "Adult Teacher Sunday School Manual 2024",
        "featuredImage":
            "https://fsqebookapp.com.ng/ebook_app/upload/cover-2024_adult_manual.png"
      }
    ];
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Featured",
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
              children: list
                  .map(
                    (item) => featuredCard(
                      title: item['featuredTitle'] as String,
                      imageUrl: item['featuredImage'] as String,
                      context: context,
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

class HomeTrendingWidget extends StatelessWidget {
  const HomeTrendingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final trendingBookList = [
      {
        "trendingId": "54",
        "trendingTitle": "Adult Teacher Sunday School Manual 2024",
        "trendingImage":
            "https://fsqebookapp.com.ng/ebook_app/upload/cover-2024_adult_manual.png",
        "trendingBookPrice": "N450.00",
        "trendingRating": 3.75
      },
      {
        "trendingId": "53",
        "trendingTitle": "House Fellowship Manual 2024",
        "trendingImage":
            "https://fsqebookapp.com.ng/ebook_app/upload/cover_unity_spirit_house_fellowship.png",
        "trendingBookPrice": "N300.00",
        "trendingRating": 5
      },
      {
        "trendingId": "49",
        "trendingTitle": "2024 Children Manual for 9 to 12 years",
        "trendingImage":
            "https://fsqebookapp.com.ng/ebook_app/upload/age9-12.png",
        "trendingBookPrice": "N250.00",
        "trendingRating": 0
      }
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Trending Books",
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
                  (item) => homeCardWidget(
                    title: item['trendingTitle'] as String,
                    url: item['trendingImage'] as String,
                    bookPrice: item['trendingBookPrice'] as String,
                    rating: (item['trendingRating'] as num).toDouble(),
                    context: context,
                  ),
                )
                .toList(),
          ),
        ),
      ],
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
                    fontSize: 14,
                    color: Color(0xFF424242),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeManualWidget extends StatelessWidget {
  const HomeManualWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final manualBookList = [
      {
        "manualId": "47",
        "manualTitle": "2024 Children Manual for 2 to 5 years",
        "manualImage": "https://fsqebookapp.com.ng/ebook_app/upload/age2-5.png",
        "manualBookPrice": "N250.00",
        "manualRating": 0
      },
      {
        "manualId": "48",
        "manualTitle": "2024 Children Manual for 6 to 8 years",
        "manualImage": "https://fsqebookapp.com.ng/ebook_app/upload/age6-8.png",
        "manualBookPrice": "N250.00",
        "manualRating": 0
      },
      {
        "manualId": "49",
        "manualTitle": "2024 Children Manual for 9 to 12 years",
        "manualImage":
            "https://fsqebookapp.com.ng/ebook_app/upload/age9-12.png",
        "manualBookPrice": "N250.00",
        "manualRating": 0
      },
      {
        "manualId": "53",
        "manualTitle": "House Fellowship Manual 2024",
        "manualImage":
            "https://fsqebookapp.com.ng/ebook_app/upload/cover_unity_spirit_house_fellowship.png",
        "manualBookPrice": "N300.00",
        "manualRating": 5
      },
      {
        "manualId": "54",
        "manualTitle": "Adult Teacher Sunday School Manual 2024",
        "manualImage":
            "https://fsqebookapp.com.ng/ebook_app/upload/cover-2024_adult_manual.png",
        "manualBookPrice": "N450.00",
        "manualRating": 3.75
      }
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Manuals",
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
            children: manualBookList
                .map(
                  (item) => homeCardWidget(
                    title: item['manualTitle'] as String,
                    url: item['manualImage'] as String,
                    bookPrice: item['manualBookPrice'] as String,
                    rating: (item['manualRating'] as num).toDouble(),
                    context: context,
                  ),
                )
                .toList(),
          ),
        ),
      ],
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
                    fontSize: 14,
                    color: Color(0xFF424242),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeCategoryWidget extends StatelessWidget {
  const HomeCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final subCategoryBookList = [
      {
        "subCategoryId": "15",
        "subCategoryTitle": "Workbook",
        "subCategoryImage":
            "https://fsqebookapp.com.ng/ebook_app/upload/images/sub_category/g.jpg"
      },
      {
        "subCategoryId": "16",
        "subCategoryTitle": "Manuals",
        "subCategoryImage":
            "https://fsqebookapp.com.ng/ebook_app/upload/images/sub_category/ot.jpg"
      },
      {
        "subCategoryId": "17",
        "subCategoryTitle": "New Testament",
        "subCategoryImage":
            "https://fsqebookapp.com.ng/ebook_app/upload/images/sub_category/nt.jpg"
      },
      {
        "subCategoryId": "18",
        "subCategoryTitle": "Gospel",
        "subCategoryImage":
            "https://fsqebookapp.com.ng/ebook_app/upload/images/sub_category/gos.jpg"
      },
      {
        "subCategoryId": "19",
        "subCategoryTitle": "Epistles",
        "subCategoryImage":
            "https://fsqebookapp.com.ng/ebook_app/upload/images/sub_category/e.jpg"
      },
      {
        "subCategoryId": "20",
        "subCategoryTitle": "Revelation",
        "subCategoryImage":
            "https://fsqebookapp.com.ng/ebook_app/upload/images/sub_category/rev.jpg"
      }
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Sub Category",
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
            children: subCategoryBookList
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: CategoryCard(
                      url: item['subCategoryImage'] as String,
                      name: item['subCategoryTitle'] as String,
                      width: 185,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
