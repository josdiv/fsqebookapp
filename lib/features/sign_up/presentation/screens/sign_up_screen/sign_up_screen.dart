import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/core/helper/common_loader.dart';
import 'package:foursquare_ebbok_app/features/sign_up/presentation/cubits/sign_up_cubit.dart';
import 'package:foursquare_ebbok_app/features/status/presentation/cubits/status_cubit.dart';

import '../../../../../core/helper/auth_form.dart';
import '../../../../../core/misc/spacer.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/ui/widgets/default_button.dart';
import '../../../../bottom_nav_bar/bottom_nav_bar.dart';
import '../../../../login/presentation/screens/login_screen/login_screen.dart';
import '../../../../profile/presentation/cubits/profile_cubit.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        final model = state.model;
        final networkModel = model.networkModel;
        final event = context.read<SignUpCubit>();

        if (networkModel.hasError) {
          showSnackBar(context, networkModel.error);
          event.signUpScreenEvent(
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

          event.signUpScreenEvent(
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
        final event = context.read<SignUpCubit>();

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
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: AppColors.blueColor,
                      ),
                    ),
                    VSpace(5),
                    Text(
                      "Let's Sign Up.",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4D506C),
                      ),
                    ),
                    VSpace(70),
                    AuthForm(
                      hintText: "Name*",
                      onChanged: (e) => event.signUpScreenEvent(
                        model.copyWith(
                          screenModel: screenModel.addName(e),
                        ),
                      ),
                      validator: screenModel.validateName,
                    ),
                    VSpace(20),
                    AuthForm(
                      hintText: "Email*",
                      onChanged: (e) => event.signUpScreenEvent(
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
                      onChanged: (e) => event.signUpScreenEvent(
                        model.copyWith(
                          screenModel: screenModel.addPassword(e),
                        ),
                      ),
                      validator: screenModel.validatePassword,
                      suffixIcon: GestureDetector(
                        onTap: () => event.signUpScreenEvent(
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
                    AuthForm(
                      hintText: "Phone (Optional)",
                      keyboardType: TextInputType.phone,
                      // validator: screenModel.validatePhoneNumber,
                      onChanged: (e) => event.signUpScreenEvent(
                        model.copyWith(
                          screenModel: screenModel.addPhone(e),
                        ),
                      ),
                    ),
                    VSpace(30),
                    GestureDetector(
                      onTap: () => event.signUpScreenEvent(
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
                    VSpace(20),
                    DefaultButton(
                      text: "REGISTER",
                      height: 60,
                      borderRadius: 10,
                      fontSize: 19,
                      opacity: screenModel.register,
                      loading: networkModel.loading,
                      onTap: () => screenModel.acceptPolicy
                          ? event.userSignUpEvent(screenModel.data)
                          : showSnackBar(
                              context, 'Accept the privacy policy to proceed'),
                    ),
                    // Spacer(),
                    VSpace(50),
                    Align(
                      child: InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        ),
                        child: Text.rich(
                          TextSpan(
                            text: "Already have an account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: ' Login',
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
