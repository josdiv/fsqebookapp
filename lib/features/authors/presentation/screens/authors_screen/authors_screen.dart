import 'package:flutter/material.dart';
import 'package:foursquare_ebbok_app/features/authors/presentation/screens/author_details_screen/author_details_screen.dart';

import '../../../../../core/misc/spacer.dart';
import '../../../../../core/theme/app_colors.dart';

class AuthorsScreen extends StatelessWidget {
  const AuthorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VSpace(80),
        AuthorsHeaderWidget(),
        Expanded(child: AuthorsGridWidget())
      ],
    );
  }
}

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

class AuthorsCard extends StatelessWidget {
  const AuthorsCard({super.key, required this.url, required this.name});

  final String url;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(url),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          name,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Color(0xFF4D506C),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

class AuthorsGridWidget extends StatelessWidget {
  const AuthorsGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        "authorId": "20",
        "authorName": "TD Jakes",
        "authorImage":
            "https://fsqebookapp.com.ng/ebook_app/upload/td-jakes.png"
      },
      {
        "authorId": "21",
        "authorName": "Joyce Meyer",
        "authorImage": "https://fsqebookapp.com.ng/ebook_app/upload/meyer.jpg"
      },
      {
        "authorId": "24",
        "authorName": "Watchman Ne...",
        "authorImage":
            "https://fsqebookapp.com.ng/ebook_app/upload/watchman.jpg"
      },
      {
        "authorId": "25",
        "authorName": "Myles Muroe",
        "authorImage": "https://fsqebookapp.com.ng/ebook_app/upload/myles.jpg"
      },
      {
        "authorId": "26",
        "authorName": "Joel Osteen",
        "authorImage": "https://fsqebookapp.com.ng/ebook_app/upload/joel.jpg"
      },
      {
        "authorId": "27",
        "authorName": "Sarah Young",
        "authorImage": "https://fsqebookapp.com.ng/ebook_app/upload/sarah.jpg"
      },
      {
        "authorId": "29",
        "authorName": "Gary Chapma...",
        "authorImage": "https://fsqebookapp.com.ng/ebook_app/upload/gary.jpg"
      },
      {
        "authorId": "31",
        "authorName": "Zig Ziglar",
        "authorImage": "https://fsqebookapp.com.ng/ebook_app/upload/zig.jpg"
      },
      {
        "authorId": "34",
        "authorName": "Foursquare ...",
        "authorImage":
            "https://fsqebookapp.com.ng/ebook_app/upload/foursquare-logo-small.png"
      }
    ];
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 2 items per row
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: .8, // Adjust to your needs
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AuthorDetailsScreen(),
            ),
          ),
          child: AuthorsCard(
            url: items[index]['authorImage'] as String,
            name: items[index]['authorName'] as String,
          ),
        );
      },
    );
  }
}
