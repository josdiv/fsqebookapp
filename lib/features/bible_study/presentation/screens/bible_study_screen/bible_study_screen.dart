import 'package:flutter/material.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';
import 'package:foursquare_ebbok_app/features/bible_study/presentation/screens/bible_study_screen/widgets/bible_study_grid_widget.dart';

import '../../../../../core/theme/app_colors.dart';

class BibleStudyScreen extends StatelessWidget {
  const BibleStudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          "Bible Study",
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
            Expanded(child: BibleStudyGridWidget())
          ],
        ),
      ),
    );
  }
}


