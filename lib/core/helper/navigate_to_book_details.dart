import 'package:flutter/material.dart';

import '../../features/book_details/presentation/screens/book_details_screen/book_details_screen.dart';

void toBookDetails({required String id, required BuildContext context}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsScreen(id: id),
      ),
    );
