import 'package:flutter/material.dart';

import '../../../../../../core/misc/spacer.dart';
import '../../../../../../core/theme/app_colors.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              "assets/images/appicon.png",
              height: 50,
            ),
            HSpace(20),
            Text(
              "eBook Store",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: AppColors.blueColor),
            ),
            Spacer(),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.purpleColor.withOpacity(.2)),
              child: Icon(Icons.settings),
            )
          ],
        ),
        VSpace(15),
        SizedBox(
          height: 45,
          child: TextFormField(
            maxLines: null,
            minLines: null,
            expands: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              suffixIcon: Icon(Icons.search),
              filled: true,
              fillColor: AppColors.purpleColor.withOpacity(.2),
              hintText: 'Search here...',
            ),
          ),
        )
      ],
    );
  }
}
