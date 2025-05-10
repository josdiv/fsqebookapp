import 'package:flutter/material.dart';
import 'package:flutter_close_app/flutter_close_app.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';
import 'package:foursquare_ebbok_app/core/ui/widgets/default_button.dart';

import '../../../../bottom_nav_bar/bottom_nav_bar.dart';

class BuyBookSuccessScreen extends StatelessWidget {
  const BuyBookSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterCloseAppPage(
      onCloseFailed: () {
        // Condition does not match: the first press or the second press interval is more than 2 seconds, display a prompt message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Press again to exit 🎉"),
          ),
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/Payment_Successful.png'),
                VSpace(30),
                Text(
                  "Payment Success",
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.blueColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                VSpace(50),
                DefaultButton(
                  text: 'BACK TO HOME',
                  borderRadius: 24,
                  opacity: true,
                  onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavBar(currentIndex: 4),
                    ),
                        (Route<dynamic> route) => false,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
