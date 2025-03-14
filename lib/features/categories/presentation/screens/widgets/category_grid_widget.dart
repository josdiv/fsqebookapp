import 'package:flutter/material.dart';

import 'category_card.dart';

class CategoryGridWidget extends StatelessWidget {
  const CategoryGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        "categoryId": "1",
        "categoryName": "Biographies",
        "categoryImage":
        "https://fsqebookapp.com.ng/ebook_app/upload/images/category/Biographies.jpg"
      },
      {
        "categoryId": "20",
        "categoryName": "Bible Study",
        "categoryImage":
        "https://fsqebookapp.com.ng/ebook_app/upload/images/category/bible  study.jpg"
      },
      {
        "categoryId": "21",
        "categoryName": "Lifestyle",
        "categoryImage":
        "https://fsqebookapp.com.ng/ebook_app/upload/images/category/life.jpg"
      },
      {
        "categoryId": "22",
        "categoryName": "Biography",
        "categoryImage":
        "https://fsqebookapp.com.ng/ebook_app/upload/images/category/biographies.jpg"
      },
      {
        "categoryId": "23",
        "categoryName": "Stories",
        "categoryImage":
        "https://fsqebookapp.com.ng/ebook_app/upload/images/category/stories.jpg"
      },
      {
        "categoryId": "24",
        "categoryName": "Family",
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
        return CategoryCard(
          url: items[index]['categoryImage'] as String,
          name: items[index]['categoryName'] as String,
        );
      },
    );
  }
}