import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';

import '../../../../../core/theme/app_colors.dart';

class AuthorDetailsScreen extends StatelessWidget {
  const AuthorDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          "Author Info",
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: AppColors.blueColor,
          ),
        ),
        centerTitle: false,
        foregroundColor: AppColors.blueColor,
        backgroundColor: Color(0xFFF5F5F5),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VSpace(10),
              AuthorInfoWidget(),
              VSpace(20),
              AuthorBooksWidget()
            ],
          ),
        ),
      ),
    );
  }
}

class AuthorBooksWidget extends StatelessWidget {
  const AuthorBooksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Author Books",
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: AppColors.blueColor,
          ),
        ),
      ],
    );
  }
}


class AuthorInfoWidget extends StatelessWidget {
  const AuthorInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFFFEEEB),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://fsqebookapp.com.ng/ebook_app/upload/meyer.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              HSpace(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Joyce Meyer",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4E4B66),
                    ),
                  ),
                  VSpace(5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/Youtube.svg",
                        height: 20,
                        width: 20,
                      ),
                      HSpace(10),
                      SvgPicture.asset(
                        "assets/icons/Fb.svg",
                        height: 20,
                        width: 20,
                      ),
                      HSpace(10),
                      SvgPicture.asset(
                        "assets/icons/Insta.svg",
                        height: 20,
                        width: 20,
                      ),
                      HSpace(10),
                      SvgPicture.asset(
                        "assets/icons/Web.svg",
                        height: 20,
                        width: 20,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          VSpace(10),
          Text(
            "Watchman Nee was a Chinese Christian author and church leader "
            "born on November 4, 1903, in Foochow, China. A prominent figure "
            "in the Christian house church movement in China, Nee authored "
            "many influential books, including \"The Normal Christian Life\" "
            "and \"Sit, Walk, Stand.\" Despite facing persecution and "
            "imprisonment during the Chinese communist regime, his writings "
            "continue to inspire Christians globally. Watchman Nee's emphasis "
            "on the deeper aspects of the Christian life and his commitment "
            "to following Christ in all circumstances have left a lasting legacy",
            style:
                TextStyle(height: 1.65, fontSize: 15, color: Color(0xFF424242)),
          )
        ],
      ),
    );
  }
}
