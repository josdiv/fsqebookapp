import 'package:flutter/material.dart';
import 'package:foursquare_ebbok_app/features/categories/presentation/screens/categories_screen/widgets/category_grid_widget.dart';
import 'package:foursquare_ebbok_app/features/categories/presentation/screens/categories_screen/widgets/category_header_widget.dart';

import '../../../../../core/misc/spacer.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VSpace(80),
        CategoryHeaderWidget(),
        Expanded(
          child: CategoryGridWidget(),
        )
      ],
    );
  }
}





