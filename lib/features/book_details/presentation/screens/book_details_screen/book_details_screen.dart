import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';

import '../../../../../core/theme/app_colors.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          "Details Page",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VSpace(40),
            BookDetailsHeader(),
            VSpace(20),
            BookDetailsIcon(),
            VSpace(20),
            AboutThisBookWidget()
          ],
        ),
      ),
    );
  }
}

class BookDetailsIcon extends StatelessWidget {
  const BookDetailsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = ['favourite', 'Download', 'read', 'Report'];
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        iconWidget(icon: "favourite", text: "Favourite"),
        spacer(),
        iconWidget(icon: "Download", text: "Download"),
        spacer(),
        iconWidget(icon: "read", text: "Read"),
        spacer(),
        iconWidget(icon: "Report", text: "Report"),
      ],
    );
  }

  Widget spacer() => Container(
        height: 30,
        width: 1,
        color: Color(0xFF4E4B66),
      );

  Widget iconWidget({required String icon, required String text}) {
    return Expanded(
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/icons/$icon.svg',
            height: 25,
          ),
          VSpace(10),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF424242),
            ),
          )
        ],
      ),
    );
  }
}

class BookDetailsHeader extends StatelessWidget {
  const BookDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180, // Give space for the image to float properly
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFFFEEEB),
              ),
              child: Row(
                children: [
                  Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .46,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tales of The Arabian Nights",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4E4B66),
                          ),
                        ),
                        Text(
                          "by Thomas Hardy",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF424242),
                          ),
                        ),
                        VSpace(10),
                        Row(
                          children: [
                            SvgPicture.asset("assets/icons/views.svg"),
                            HSpace(6),
                            Text(
                              "1245",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF424242),
                              ),
                            ),
                          ],
                        ),
                        VSpace(10),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.red,
                          ),
                          child: Text(
                            "NGN 2000",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -30,
            left: 20,
            child: Container(
              height: 190.14,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15)
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(
                    "https://fsqebookapp.com.ng/ebook_app/upload/2025 House Fellowship Manual Cov.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AboutThisBookWidget extends StatelessWidget {
  const AboutThisBookWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About this book",
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: AppColors.blueColor,
          ),
        ),
        Text(
          "The theme, \"Authentic Christianity,\" calls us back to the core of our faith&mdash;living as faithful "
          "disciples of Christ in every aspect of our lives. In a world "
          "filled with distractions and challenges, the need for believers "
          "to embody genuine Christian values is more critical than ever. "
          "Through this manual, we aim to provide biblical teachings, "
          "practical guidance, and spiritual encouragement for believers "
          "to nurture their faith and walk in alignment with God's Word.",
        )
      ],
    );
  }
}

class RatingsAndReview extends StatelessWidget {
  const RatingsAndReview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

