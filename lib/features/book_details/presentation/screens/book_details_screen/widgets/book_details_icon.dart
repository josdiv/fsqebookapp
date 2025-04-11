import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/misc/spacer.dart';

class BookDetailsIcon extends StatelessWidget {
  const BookDetailsIcon({super.key});

  @override
  Widget build(BuildContext context) {
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