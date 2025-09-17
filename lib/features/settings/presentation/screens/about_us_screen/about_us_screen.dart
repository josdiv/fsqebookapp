import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';
import 'package:foursquare_ebbok_app/features/settings/presentation/cubits/settings_cubit.dart';

import '../../../../../core/misc/spacer.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          "About Us",
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
              aboutUsWidget(
                title: "Foursquare eBook Store",
                subtitle: "1.0.0",
              ),
              VSpace(20),
              aboutUsWidget(
                title: "App Version",
                iconData: Icons.info_outline,
                subtitle: "1.0.0",
              ),
              VSpace(20),
              aboutUsWidget(
                title: "Company",
                iconData: Icons.apartment,
                subtitle: "Dawn Global ICT Intserve limited",
              ),
              VSpace(20),
              aboutUsWidget(
                title: "Email",
                iconData: Icons.email,
                subtitle: "support@fsqebookapp.com.ng",
              ),
              VSpace(20),
              aboutUsWidget(
                title: "Website",
                iconData: Icons.language_outlined,
                subtitle: "www.dgenigeria.com",
              ),
              VSpace(20),
              aboutUsWidget(
                title: "Contact",
                iconData: Icons.contact_phone_outlined,
                subtitle: "+234 8065672050",
              ),
              VSpace(30),
              AboutUsContentWidget()
            ],
          ),
        ),
      ),
    );
  }

  Widget aboutUsWidget({
    required String title,
    required String subtitle,
    IconData? iconData,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF3F3D5b).withValues(alpha: .1)),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFF716A).withValues(alpha: .15),
              image: iconData == null
                  ? DecorationImage(
                image: AssetImage("assets/images/app-icon.jpg"),
                fit: BoxFit.cover,
              )
                  : null,
            ),
            alignment: Alignment.center,
            child: Icon(
              iconData,
              color: Color(0xFFF97F68),
            ),
          ),
          HSpace(12),
          iconData == null
              ? Text(
            title,
            style: TextStyle(
              color: Color(0xFF4E4B66),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Color(0xFF65637B),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              VSpace(4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Color(0xFF65637B).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  subtitle,
                  style: TextStyle(
                    color: Color(0xFF65637B),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}


class AboutUsContentWidget extends StatelessWidget {
  const AboutUsContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF3F3D5b).withValues(alpha: .1)),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About Us",
                style: TextStyle(
                  color: Color(0xFF65637B),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              VSpace(20),
              Text(
                state is AboutUsLoadedState ? state.aboutUs : "Could not fetch content",
                style: TextStyle(
                  color: Color(0xFF65637B).withValues(alpha: .9),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
