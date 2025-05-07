import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../home/presentation/screens/search_books_page/search_books_page.dart';

class LatestHeaderWidget extends StatelessWidget {
  const LatestHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToSearch(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SearchBooksPage()),
      );
    }

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
        GestureDetector(
          onTap: () => navigateToSearch(context),
          child: Icon(Icons.search),
        )
      ],
    );
  }
}
