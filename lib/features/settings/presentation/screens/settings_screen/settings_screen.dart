import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:foursquare_ebbok_app/core/helper/common_loader.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';
import 'package:foursquare_ebbok_app/features/login/presentation/screens/login_screen/login_screen.dart';
import 'package:foursquare_ebbok_app/features/settings/presentation/cubits/settings_cubit.dart';
import 'package:foursquare_ebbok_app/features/settings/presentation/screens/about_us_screen/about_us_screen.dart';
import 'package:foursquare_ebbok_app/features/settings/presentation/screens/account_deletion_screen/account_deletion_screen.dart';
import 'package:foursquare_ebbok_app/features/settings/presentation/screens/terms_of_use_screen/terms_of_use_screen.dart';
import 'package:foursquare_ebbok_app/features/status/presentation/cubits/status_cubit.dart';

import '../../../../bottom_nav_bar/bottom_nav_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void dispose() {
    super.dispose();
    Loader.hide();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is AboutUsLoadingState) {
          commonLoader(context);
        }

        if (state is AboutUsErrorState) {
          Loader.hide();
          showSnackBar(context, state.error);
        }

        if (state is AboutUsLoadedState) {
          Loader.hide();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AboutUsScreen()),
          );
        }

        if (state is TermsOfUseLoadingState) {
          commonLoader(context);
        }

        if (state is TermsOfUseErrorState) {
          Loader.hide();
          showSnackBar(context, state.error);
        }

        if (state is TermsOfUseLoadedState) {
          Loader.hide();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TermsOfUseScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        void showLogoutDialog(BuildContext context) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text('Logout'),
              content: const Text('Are you sure you want to logout?'),
              actionsPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    context.read<StatusCubit>().setUserLoginStatusEvent(false);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavBar(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Red for "Yes"
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Just close dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Grey for "No"
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'No',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        final isUserLoggedIn =
            context.read<StatusCubit>().state.model.isUserLoggedIn;
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            title: Text(
              "Settings",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: AppColors.blueColor,
              ),
            ),
            centerTitle: false,
            foregroundColor: AppColors.blueColor,
            backgroundColor: Color(0xFFF5F5F5),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  settingsWidget(
                    text: isUserLoggedIn ? "Logout" : "Login",
                    iconData: isUserLoggedIn
                        ? Icons.logout_outlined
                        : Icons.login_outlined,
                    onTap: !isUserLoggedIn
                        ? () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            )
                        : () => showLogoutDialog(context),
                  ),
                  settingsWidget(
                    text: "About App",
                    iconData: Icons.info_outline,
                    onTap: () =>
                        context.read<SettingsCubit>().getAboutUsEvent(),
                  ),
                  settingsWidget(
                    text: "Terms of Use",
                    iconData: Icons.description_outlined,
                    onTap: () =>
                        context.read<SettingsCubit>().getTermsOfUseEvent(),
                  ),
                  settingsWidget(
                    text: "Delete Account",
                    iconData: Icons.delete_forever_outlined,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccountDeletionScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget settingsWidget({
    required String text,
    required IconData iconData,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          const Divider(),
          Row(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFFF716A).withOpacity(.15)),
                alignment: Alignment.center,
                child: Icon(
                  iconData,
                  color: Color(0xFFF97F68),
                ),
              ),
              HSpace(20),
              Text(
                text,
                style: TextStyle(
                  color: Color(0xFF4E4B66),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Icon(Icons.keyboard_arrow_right)
            ],
          ),
          VSpace(10),
        ],
      ),
    );
  }
}
