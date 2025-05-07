import 'package:flutter/material.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';

import '../../features/book_details/presentation/screens/book_details_screen/book_details_screen.dart';

void toBookDetails({required DataMap data, required BuildContext context}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsScreen(data: data),
      ),
    );
