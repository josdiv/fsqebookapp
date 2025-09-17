import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:foursquare_ebbok_app/core/helper/common_loader.dart';
import 'package:foursquare_ebbok_app/features/login/presentation/cubits/login_cubit.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../bottom_nav_bar/bottom_nav_bar.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email'],
);

class GoogleSignInWidget extends StatefulWidget {
  const GoogleSignInWidget({
    super.key,
  });

  @override
  State<GoogleSignInWidget> createState() => _GoogleSignInWidgetState();
}

class _GoogleSignInWidgetState extends State<GoogleSignInWidget> {
  @override
  Widget build(BuildContext context) {
    Future<void> handleGoogleSignIn() async {
      try {
        final GoogleSignInAccount? account = await _googleSignIn.signIn();

        if (account != null) {
          final String id = account.id;
          final String name = account.displayName ?? '';
          final String email = account.email;

          debugPrint('Google ID: $id');
          debugPrint('Name: $name');
          debugPrint('Email: $email');

          if (context.mounted) {
            context.read<LoginCubit>().signInWithGoogleEvent({
              'googleId': id,
              'googleName': name,
              'googleEmail': email,
            });
          }

          // TODO: Send `id`, `name`, and `email` to your REST API
        } else {
          debugPrint('User cancelled the sign-in');
          if (context.mounted) {
            showSnackBar(context, 'User cancelled the sign-in');
          }
        }
      } catch (e) {
        debugPrint('Google Sign-In error: $e');
        if (context.mounted) {
          showSnackBar(context, 'Google Sign-In error: $e');
        }
      }
    }

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        final model = state.model;
        final networkModel = model.networkModel;
        final event = context.read<LoginCubit>();

        if (networkModel.loading) {
          commonLoader(context);
        }

        if (networkModel.hasError && Loader.isShown) {
          Loader.hide();
          event.signInScreenEvent(
            model.copyWith(
              networkModel: networkModel.copyWith(
                error: '',
              ),
            ),
          );
        }

        if (networkModel.loaded && Loader.isShown) {
          Loader.hide();
          event.signInScreenEvent(
            model.copyWith(
              networkModel: networkModel.copyWith(
                loaded: false,
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
      child: Align(
        child: InkWell(
          onTap: handleGoogleSignIn,
          child: Image.asset('assets/icons/google1.png'),
        ),
      ),
    );
  }
}
