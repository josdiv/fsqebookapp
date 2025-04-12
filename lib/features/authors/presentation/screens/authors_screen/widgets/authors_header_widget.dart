import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';

class AuthorsHeaderWidget extends StatelessWidget {
  const AuthorsHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Authors",
      style: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.bold,
        color: AppColors.blueColor,
      ),
    );
  }
}