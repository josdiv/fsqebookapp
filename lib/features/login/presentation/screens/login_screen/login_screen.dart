import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';
import 'package:foursquare_ebbok_app/core/ui/widgets/default_button.dart';
import 'package:foursquare_ebbok_app/features/bottom_nav_bar/bottom_nav_bar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VSpace(60),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomNavBar(),
                  ),
                      (Route<dynamic> route) => false,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.orangeColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              "Welcome Back!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: AppColors.blueColor,
              ),
            ),
            VSpace(5),
            Text(
              "Login to continue",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4D506C),
              ),
            ),
            VSpace(100),
            AuthForm(hintText: "Email*"),
            VSpace(20),
            AuthForm(hintText: "Password", hasIcon: true),
            VSpace(20),
            Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey),
                  ),
                ),
                HSpace(5),
                Text(
                  'Remember Me',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text(
                  'Forgot Password?',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            VSpace(30),
            DefaultButton(
              text: "LOG IN",
              height: 60,
              borderRadius: 10,
              fontSize: 19,
            ),
            VSpace(20),
            Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey),
                  ),
                ),
                HSpace(5),
                Text.rich(
                  TextSpan(
                    text: "By Signing in you accept",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: ' Privacy Policy',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF97F68),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            VSpace(50),
            Align(
              child: Text(
                'Or continue with',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            VSpace(20),
            // SvgPicture.asset('assets/icons/google1.png')
            Align(
              child: Image.asset('assets/icons/google1.png'),
            )
          ],
        ),
      ),
    );
  }
}

class AuthForm extends StatelessWidget {
  const AuthForm({super.key, this.hintText, this.hasIcon = false});

  final String? hintText;
  final bool hasIcon;

  @override
  Widget build(BuildContext context) {
    final isPasswordField = hasIcon;

    return SizedBox(
      height: 60,
      child: TextFormField(
        obscureText: isPasswordField,
        maxLines: isPasswordField ? 1 : null,
        expands: isPasswordField ? false : true,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xffDDDDDD),
            ),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
            fontWeight: FontWeight.w700,
          ),
          suffixIcon: isPasswordField ? const Icon(Icons.visibility_off) : null,
        ),
      ),
    );
  }
}

