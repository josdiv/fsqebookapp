import 'package:flutter/material.dart';
import 'package:foursquare_ebbok_app/features/authors/presentation/screens/authors_screen/widgets/authors_grid_widget.dart';
import 'package:foursquare_ebbok_app/features/authors/presentation/screens/authors_screen/widgets/authors_header_widget.dart';

import '../../../../../core/misc/spacer.dart';

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
