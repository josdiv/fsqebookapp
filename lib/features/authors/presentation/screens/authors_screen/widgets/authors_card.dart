import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AuthorsCard extends StatelessWidget {
  const AuthorsCard({super.key, required this.url, required this.name});

  final String url;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: CachedNetworkImage(
            imageUrl: url,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              width: 100,
              height: 100,
              color: Colors.grey.shade200,
              child: const Icon(Icons.person, size: 40, color: Colors.grey),
            ),
            errorWidget: (context, url, error) => Container(
              width: 100,
              height: 100,
              color: Colors.grey.shade200,
              child: const Icon(Icons.person, size: 40, color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          name,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF4D506C),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
