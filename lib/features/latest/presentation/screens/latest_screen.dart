import 'package:flutter/material.dart';
import 'package:foursquare_ebbok_app/features/latest/presentation/screens/widgets/latest_grid_widget.dart';
import 'package:foursquare_ebbok_app/features/latest/presentation/screens/widgets/latest_header_widget.dart';

import '../../../../core/misc/spacer.dart';

class LatestScreen extends StatelessWidget {
  const LatestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VSpace(80),
        LatestHeaderWidget(),
        Expanded(
          child: LatestGridWidget(),
        )
      ],
    );
  }
}
