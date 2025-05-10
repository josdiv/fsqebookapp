import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';
import 'package:foursquare_ebbok_app/features/login/presentation/screens/login_screen/login_screen.dart';
import 'package:foursquare_ebbok_app/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:foursquare_ebbok_app/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:foursquare_ebbok_app/features/profile/presentation/screens/profile_screen/widgets/modal_content.dart';
import 'package:foursquare_ebbok_app/features/status/presentation/cubits/status_cubit.dart';

import '../../../../../core/misc/spacer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
    final email = context
        .read<ProfileCubit>()
        .state
        .model
        .networkModel
        .profile
        .userEmail;
    context.read<ProfileCubit>().getUserProfileEvent(email);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusCubit, StatusState>(
      builder: (context, state) {
        final isUserLoggedIn = state.model.isUserLoggedIn;

        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VSpace(80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    if (isUserLoggedIn)
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileEditScreen(),
                          ),
                        ),
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              isUserLoggedIn
                  ? BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        final profile = state.model.networkModel.profile;
                        final userName = profile.userName;
                        final email = profile.userEmail;
                        final profilePic = profile.profileImage;

                        return Expanded(
                          child: Column(
                            children: [
                              VSpace(30),
                              Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(profilePic),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              VSpace(5),
                              Text(
                                userName,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFF4F4F4),
                                ),
                              ),
                              Text(
                                email,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFFF4F4F4),
                                ),
                              ),
                              VSpace(20),
                              Expanded(child: const ModalContent())
                            ],
                          ),
                        );
                      },
                    )
                  : Expanded(
                      child: Column(
                        children: [
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
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 13, horizontal: 25),
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
                              ),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
