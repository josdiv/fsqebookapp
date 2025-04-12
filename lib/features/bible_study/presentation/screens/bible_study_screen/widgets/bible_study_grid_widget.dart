import 'package:flutter/material.dart';

import '../../../../../categories/presentation/screens/categories_screen/widgets/category_card.dart';


class BibleStudyGridWidget extends StatelessWidget {
  const BibleStudyGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        "categoryId": "1",
        "categoryName": "Epistles",
        "categoryImage":
        "https://fsqebookapp.com.ng/ebook_app/upload/images/category/Biographies.jpg"
      },
      {
        "categoryId": "20",
        "categoryName": "Gospel",
        "categoryImage":
        "https://fsqebookapp.com.ng/ebook_app/upload/images/category/bible  study.jpg"
      },
      {
        "categoryId": "21",
        "categoryName": "Manuals",
        "categoryImage":
        "https://fsqebookapp.com.ng/ebook_app/upload/images/category/life.jpg"
      },
      {
        "categoryId": "22",
        "categoryName": "New Testament",
        "categoryImage":
        "https://fsqebookapp.com.ng/ebook_app/upload/images/category/biographies.jpg"
      },
      {
        "categoryId": "23",
        "categoryName": "Revelation",
        "categoryImage":
        "https://fsqebookapp.com.ng/ebook_app/upload/images/category/stories.jpg"
      },
      {
        "categoryId": "24",
        "categoryName": "Workbook",
        "categoryImage":
        "https://fsqebookapp.com.ng/ebook_app/upload/images/category/family.jpg"
      }
    ];
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 items per row
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.5, // Adjust to your needs
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          // onTap: items[index]['categoryId'] == "20"
          //     ? () => Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const BibleStudyScreen(),
          //   ),
          // )
          //     : null,
          child: CategoryCard(
            url: items[index]['categoryImage'] as String,
            name: items[index]['categoryName'] as String,
          ),
        );
      },
    );
  }
}