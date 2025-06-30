import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';
import 'package:foursquare_ebbok_app/core/ui/widgets/default_button.dart';
import 'package:foursquare_ebbok_app/features/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:foursquare_ebbok_app/features/login/presentation/cubits/login_cubit.dart';
import 'package:foursquare_ebbok_app/features/login/presentation/screens/login_screen/widgets/google_sign_in_widget.dart';
import 'package:foursquare_ebbok_app/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:foursquare_ebbok_app/features/sign_up/presentation/screens/sign_up_screen/sign_up_screen.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../../core/helper/auth_form.dart';
import '../../../../../core/helper/common_loader.dart';
import '../../../../status/presentation/cubits/status_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    void showError(String message) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }

    Future<void> signInWithApple() async {
      print("SIGN IN");
      try {
        final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );
        print(appleCredential);

        final oauthCredential = OAuthProvider("apple.com").credential(
          idToken: appleCredential.identityToken,
          accessToken: appleCredential.authorizationCode,
        );

        final userCredential = await auth.signInWithCredential(oauthCredential);

        // Save user's name only on first login
        if (appleCredential.givenName != null) {
          final displayName =
              "${appleCredential.givenName} ${appleCredential.familyName}";
          await userCredential.user?.updateDisplayName(displayName);
          print('Apple ID: ${appleCredential.userIdentifier}');
          print('Name: $displayName');
          print('Email: ${appleCredential.email}');

          if (context.mounted) {
            context.read<LoginCubit>().signInWithGoogleEvent({
              'googleId': appleCredential.userIdentifier,
              'googleName': displayName,
              'googleEmail': appleCredential.email,
            });
          }
        }
        // Check if we have email (first login) or need to use existing
        String? email = appleCredential.email;
        if (email == null) {
          // Subsequent login - try to get email from Firebase user
          email = userCredential.user?.email;
          if (email != null) {
            print('Apple ID: ${appleCredential.userIdentifier}');
            print('Name: ${userCredential.user?.displayName}');
            print('Email: $email');
            if (context.mounted) {
              context.read<LoginCubit>().signInWithGoogleEvent({
                'googleId': appleCredential.userIdentifier,
                'googleName': userCredential.user?.displayName,
                'googleEmail': email,
              });
            }
          }
          if (email == null) {
            // If still null, prompt user to enter email manually
            showError('Please provide your email to complete registration');
            return;
          }
        }
      } catch (e) {
        showError('Apple Sign-In failed: $e');
        print(e);
      }
    }

    // Future<void> signInWithApple() async {
    //   print("SIGN IN WITH APPLE");
    //   try {
    //     final appleCredential = await SignInWithApple.getAppleIDCredential(
    //       scopes: [
    //         AppleIDAuthorizationScopes.email,
    //         AppleIDAuthorizationScopes.fullName,
    //       ],
    //     );
    //
    //     // Debug print all credential information
    //     print('Apple Credential: ${appleCredential.toString()}');
    //
    //     final oauthCredential = OAuthProvider("apple.com").credential(
    //       idToken: appleCredential.identityToken,
    //       accessToken: appleCredential.authorizationCode,
    //     );
    //
    //     final userCredential = await auth.signInWithCredential(oauthCredential);
    //
    //     // Handle user info
    //     if (appleCredential.givenName != null) {
    //       final displayName =
    //           "${appleCredential.givenName} ${appleCredential.familyName ?? ''}"
    //               .trim();
    //       await userCredential.user?.updateDisplayName(displayName);
    //     }
    //
    //     // Check if we have email (first login) or need to use existing
    //     String? email = appleCredential.email;
    //     if (email == null) {
    //       // Subsequent login - try to get email from Firebase user
    //       email = userCredential.user?.email;
    //       if (email == null) {
    //         // If still null, prompt user to enter email manually
    //         showError('Please provide your email to complete registration');
    //         return;
    //       }
    //     }
    //
    //     print('Apple ID: ${appleCredential.userIdentifier}');
    //     print('Email: $email');
    //
    //     // Proceed with your login logic using the email
    //   } catch (e) {
    //     showError('Apple Sign-In failed: $e');
    //     print('Apple Sign-In Error: $e');
    //   }
    // }

    // Future<void> signInWithApple() async {
    //   print("SIGN IN");
    //   try {
    //     final appleCredential = await SignInWithApple.getAppleIDCredential(
    //       scopes: [
    //         AppleIDAuthorizationScopes.email,
    //         AppleIDAuthorizationScopes.fullName,
    //       ],
    //     );
    //     print(
    //         "Apple Credential Email: ${appleCredential.email}"); // This will show null on subsequent logins
    //
    //     final oauthCredential = OAuthProvider("apple.com").credential(
    //       idToken: appleCredential.identityToken,
    //       accessToken: appleCredential.authorizationCode,
    //     );
    //
    //     final userCredential = await auth.signInWithCredential(oauthCredential);
    //
    //     // Get the current user from Firebase Auth
    //     final currentUser = userCredential.user;
    //
    //     // Check if it's the first time the user is signing in via Apple,
    //     // or if the displayName/email is not yet set in Firebase/your database.
    //     // appleCredential.givenName and appleCredential.email will only be non-null on first sign-in.
    //     if (appleCredential.givenName != null ||
    //         appleCredential.email != null) {
    //       final displayName =
    //           "${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}"
    //               .trim();
    //       final email = appleCredential.email;
    //
    //       // Update displayName in Firebase if it's not already set or is different
    //       if (currentUser?.displayName == null ||
    //           currentUser?.displayName != displayName) {
    //         if (displayName.isNotEmpty) {
    //           await currentUser?.updateDisplayName(displayName);
    //         }
    //       }
    //
    //       // You'll need to store the email in your database or a persistent local storage
    //       // because Firebase's user.email will be set from the identityToken, but
    //       // subsequent appleCredential.email can be null.
    //       if (email != null && currentUser?.email != email) {
    //         // Here, you would typically save the email to your backend database
    //         // associated with the user's Firebase UID, or update the email in Firebase
    //         // if you have the proper re-authentication flow in place.
    //         // For simplicity, let's just print it here.
    //         print('Saving Email to DB/Profile: $email');
    //         // Example: await saveUserEmailToFirestore(currentUser.uid, email);
    //       }
    //
    //       print('Apple ID: ${appleCredential.userIdentifier}');
    //       print('Name: $displayName');
    //       print(
    //           'Email (from Apple Credential): ${email}'); // This might be null
    //       print(
    //           'Email (from Firebase User): ${currentUser?.email}'); // This should persist after first login if set by Firebase
    //     } else {
    //       // For subsequent logins, appleCredential.email and givenName will be null.
    //       // You should retrieve the stored email/name from your database or Firebase user object.
    //       print('Subsequent login. Retrieving name/email from stored data.');
    //       print('Apple ID: ${appleCredential.userIdentifier}');
    //       print(
    //           'Name: ${currentUser?.displayName}'); // Get display name from Firebase user
    //       print(
    //           'Email: ${currentUser?.email}'); // Get email from Firebase user (if it was set during first login)
    //     }
    //
    //     // if (context.mounted) {
    //     //  context.read<LoginCubit>().signInWithGoogleEvent({
    //     //    'googleId': appleCredential.userIdentifier, // Note: This is an Apple ID, not Google ID
    //     //    'googleName': currentUser?.displayName,    // Use the name from the Firebase user
    //     //    'googleEmail': currentUser?.email,       // Use the email from the Firebase user
    //     //  });
    //     // }
    //   } catch (e) {
    //     showError('Apple Sign-In failed: $e');
    //     print(e);
    //   }
    // }

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        final model = state.model;
        final networkModel = model.networkModel;
        final event = context.read<LoginCubit>();

        if (networkModel.hasError) {
          // print(networkModel.error);
          showSnackBar(context, networkModel.error);
          event.signInScreenEvent(
            model.copyWith(
              networkModel: networkModel.copyWith(
                error: '',
              ),
            ),
          );
        }

        if (networkModel.loaded) {
          context.read<StatusCubit>().setUserLoginStatusEvent(true);
          context.read<ProfileCubit>().getUserProfileEvent(
              state.model.networkModel.user.profileDetails.email);
          event.signInScreenEvent(
            model.copyWith(
              networkModel: networkModel.copyWith(
                loaded: true,
              ),
            ),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavBar(),
            ),
            (Route<dynamic> route) => false,
          );
        }
      },
      builder: (context, state) {
        final model = state.model;
        final screenModel = model.screenModel;
        final networkModel = model.networkModel;
        final event = context.read<LoginCubit>();

        return Scaffold(
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
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
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
                    AuthForm(
                      hintText: "Email*",
                      onChanged: (e) => event.signInScreenEvent(
                        model.copyWith(
                          screenModel: screenModel.addEmail(e),
                        ),
                      ),
                      validator: screenModel.validateEmail,
                    ),
                    VSpace(20),
                    AuthForm(
                      hintText: "Password*",
                      hasIcon: !screenModel.viewPassword,
                      onChanged: (e) => event.signInScreenEvent(
                        model.copyWith(
                          screenModel: screenModel.addPassword(e),
                        ),
                      ),
                      validator: screenModel.validatePassword,
                      suffixIcon: GestureDetector(
                        onTap: () => event.signInScreenEvent(
                          model.copyWith(
                            screenModel: screenModel.togglePassword(),
                          ),
                        ),
                        child: Icon(
                          screenModel.viewPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                    VSpace(20),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => event.signInScreenEvent(
                            model.copyWith(
                              screenModel: screenModel.toggleRememberMe(),
                            ),
                          ),
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey),
                              color: screenModel.rememberMe
                                  ? AppColors.orangeColor
                                  : null,
                            ),
                          ),
                        ),
                        HSpace(5),
                        Text(
                          'Remember Me',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
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
                      opacity: screenModel.login,
                      loading: networkModel.loading,
                      onTap: () => screenModel.acceptPolicy
                          ? event.signInWithPasswordEvent(screenModel.data)
                          : showSnackBar(context,
                              'Please accept the privacy policy to proceed'),
                    ),
                    VSpace(20),
                    GestureDetector(
                      onTap: () => event.signInScreenEvent(
                        model.copyWith(
                          screenModel: screenModel.togglePolicy(),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey),
                              color: screenModel.acceptPolicy
                                  ? AppColors.orangeColor
                                  : null,
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
                    Platform.isIOS
                        ? SignInWithAppleButton(
                            onPressed: signInWithApple,
                            style: SignInWithAppleButtonStyle.black,
                          )
                        : GoogleSignInWidget(),

                    VSpace(50),
                    Align(
                      child: InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        ),
                        child: Text.rich(
                          TextSpan(
                            text: "Don't have an account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: ' Sign Up',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFF97F68),
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    VSpace(50)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
