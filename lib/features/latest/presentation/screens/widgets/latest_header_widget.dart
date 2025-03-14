import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class LatestHeaderWidget extends StatelessWidget {
  const LatestHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Latest",
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: AppColors.blueColor,
          ),
        ),
        Icon(Icons.search)
      ],
    );
  }
}