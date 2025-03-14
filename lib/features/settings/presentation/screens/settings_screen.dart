import 'package:flutter/material.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';

import '../../../../core/misc/spacer.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VSpace(80),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Profile",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Spacer(),
          Column(
            children: [
              Text(
                "Login Required",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              VSpace(20),
              Container(
                padding: EdgeInsets.symmetric(vertical: 13, horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'LOG IN',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.orangeColor,
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
