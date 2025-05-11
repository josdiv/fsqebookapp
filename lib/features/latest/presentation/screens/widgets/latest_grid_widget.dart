import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/core/helper/navigate_to_book_details.dart';
import 'package:foursquare_ebbok_app/features/latest/presentation/cubits/latest_cubit.dart';

import '../../../../profile/presentation/cubits/profile_cubit.dart';
import '../../../../status/presentation/cubits/status_cubit.dart';
import 'latest_card_widget.dart';

class LatestGridWidget extends StatelessWidget {
  const LatestGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LatestCubit, LatestState>(
      builder: (context, state) {
        final latestBooks = state.model.latestBooks;
        final loading = state.model.loadOnce;
        final isUserLoggedIn =
            context.read<StatusCubit>().state.model.isUserLoggedIn;
        final profile =
            context.read<ProfileCubit>().state.model.networkModel.profile;

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 15,
            mainAxisSpacing: 0,
            childAspectRatio: (MediaQuery.of(context).size.width / 2) /
                400, // Adjust to your needs
          ),
          itemCount: loading ? 6 : latestBooks.length,
          itemBuilder: (context, index) {
            if (loading) {
              return const LatestCardShimmer();
            }
            return GestureDetector(
              onTap: () {
                toBookDetails(
                  data: {
                    'id': latestBooks[index].bookId,
                    'userId': isUserLoggedIn ? profile.userId : '',
                  },
                  context: context,
                );
              },
              child: LatestCardWidget(
                title: latestBooks[index].bookTitle,
                url: latestBooks[index].bookImage,
                rating: (latestBooks[index].ratingCount).toDouble(),
                price: latestBooks[index].bookPrice,
              ),
            );
          },
        );
      },
    );
  }
}
