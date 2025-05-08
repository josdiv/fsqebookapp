import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/cubits/book_details_cubit.dart';
import 'package:foursquare_ebbok_app/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:foursquare_ebbok_app/features/status/presentation/cubits/status_cubit.dart';

import '../../../../../../core/misc/spacer.dart';
import '../../../../../login/presentation/screens/login_screen/login_screen.dart';

class BookDetailsIcon extends StatelessWidget {
  const BookDetailsIcon({super.key, required this.bookId});

  final String bookId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookDetailsCubit, BookDetailsState>(
      builder: (context, state) {
        final model = state.model;
        final favStatus = model.favStatus;
        final event = context.read<BookDetailsCubit>();
        final userId = context
            .read<ProfileCubit>()
            .state
            .model
            .networkModel
            .profile
            .userId;

        return Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            iconWidget(
              icon: favStatus ? "favourite_filled" : "favourite",
              text: "Favourite",
              context: context,
              onTap: () {
                event.bookDetailsScreenEvent(
                  model.copyWith(
                    favStatus: !favStatus,
                  ),
                );
                Future.delayed(Duration(seconds: 2), () {
                  event.toggleFavouriteEvent({
                    "userId": userId,
                    "bookId": bookId,
                  });
                });
              },
            ),
            spacer(),
            iconWidget(
              icon: "Download",
              text: "Download",
              context: context,
            ),
            spacer(),
            iconWidget(
              icon: "read",
              text: "Read",
              context: context,
              onTap: () => event.readBookEvent({
                "userId": userId,
                "bookId": bookId,
              }),
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
      },
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
      child: InkWell(
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
