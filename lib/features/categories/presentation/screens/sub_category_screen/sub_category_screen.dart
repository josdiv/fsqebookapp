import 'package:flutter/material.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';
import 'package:foursquare_ebbok_app/features/categories/presentation/screens/sub_category_screen/widgets/sub_category_grid_widget.dart';

import '../../../../../core/theme/app_colors.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key});
  // final String title;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          'title',
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
          children: [
            VSpace(20),
            Expanded(child: SubCategoryGridWidget())
          ],
        ),
      ),
    );
  }
}


