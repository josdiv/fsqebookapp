import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foursquare_ebbok_app/features/status/presentation/cubits/status_cubit.dart';

import '../../../../../../core/misc/spacer.dart';
import '../../../../../login/presentation/screens/login_screen/login_screen.dart';

class BookDetailsIcon extends StatelessWidget {
  const BookDetailsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        iconWidget(
          icon: "favourite",
          text: "Favourite",
          context: context,
          onTap: () {},
        ),
        spacer(),
        iconWidget(
          icon: "Download",
          text: "Download",
          context: context,
          onTap: () {},
        ),
        spacer(),
        iconWidget(
          icon: "read",
          text: "Read",
          context: context,
          onTap: () {},
        ),
        spacer(),
        iconWidget(
          icon: "Report",
          text: "Report",
          context: context,
          onTap: () {},
        ),
      ],
    );
  }

  Widget spacer() => Container(
        height: 30,
        width: 1,
        color: Color(0xFF4E4B66),
      );

  Widget iconWidget({
    required String icon,
    required String text,
    required BuildContext context,
    VoidCallback? onTap,
  }) {
    final isUserLoggedIn =
        context.read<StatusCubit>().state.model.isUserLoggedIn;

    return Expanded(
      child: GestureDetector(
        onTap: isUserLoggedIn
            ? onTap
            : () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                ),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/icons/$icon.svg',
              height: 25,
            ),
            VSpace(10),
            Text(
              text,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF424242),
              ),
            )
          ],
        ),
      ),
    );
  }
}
