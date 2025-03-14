import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.url,
    required this.name,
    this.width,
  });

  final String url;
  final String name;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: width ?? MediaQuery.of(context).size.width,
          height: 121,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(url),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3), // Shadow color
                spreadRadius: 0, // No spread
                blurRadius: 10, // How soft the shadow should be
                offset: Offset(0, 10), // Moves shadow 10px downward
              ),
            ],
          ),
          alignment: Alignment.bottomLeft,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 60, // Adjust height for a softer fade
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.redColor.withOpacity(0.0),
                  // Fully transparent start (smooth blend)
                  AppColors.redColor.withOpacity(0.1),
                  // Very light shadow
                  AppColors.redColor.withOpacity(0.3),
                  // Medium shadow
                  AppColors.redColor.withOpacity(0.5),
                  // Darkest shadow at bottom
                ],
                stops: [0.0, 0.3, 0.7, 1.0], // Controls blending smoothness
              ),
            ),
          ),
        ),
      ],
    );
  }
}
