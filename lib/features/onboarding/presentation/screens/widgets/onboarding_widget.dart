import 'package:flutter/material.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final String image;
  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 10),
          height: MediaQuery.of(context).size.height * .4,
          decoration: BoxDecoration(
            // border:border Border.all(),
            image: DecorationImage(
              image: AssetImage('assets/images/$image.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        VSpace(20),
        Text(
          title,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        VSpace(30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 17,
                color: Color(0xFF4D506C),
                fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}
