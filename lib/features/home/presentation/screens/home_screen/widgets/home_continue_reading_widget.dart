import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';
import 'package:foursquare_ebbok_app/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/open_book/open_book.dart';
import '../../../../../book_details/presentation/cubits/book_details_cubit.dart';

class HomeContinueReadingWidget extends StatelessWidget {
  const HomeContinueReadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final profile = state.model.networkModel.profile;
        final books = profile.listReadingBook;
        return BlocListener<BookDetailsCubit, BookDetailsState>(
          listener: (context, state) {
            final model = state.model;
            final readBook = model.readBookModel;
            final event = context.read<BookDetailsCubit>();

            if (readBook.loaded) {
              debugPrint("Loaded Read 2");
              event.bookDetailsScreenEvent(
                model.copyWith(
                  readBookModel: readBook.copyWith(
                    loaded: false,
                  ),
                ),
              );
              openBook(context, readBook.entity.bookUrl, '');
            }
          },
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Continue Reading',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blueColor,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_outlined,
                    color: AppColors.orangeColor,
                  )
                ],
              ),
              VSpace(10),
              SizedBox(
                height: 230, // keep this if you want
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  // remove vertical padding
                  itemCount: books.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return GestureDetector(
                      onTap: () =>
                          context.read<BookDetailsCubit>().readBookEvent({
                        'userId': profile.userId,
                        'bookId': book.readingBookId,
                      }),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 160, // reduce image height
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey.shade200,
                              image: DecorationImage(
                                image: NetworkImage(book.readingBookImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: 120,
                            child: Text(
                              book.readingBookTitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )

              // VSpace(20),
            ],
          ),
        );
      },
    );
  }
}

class ShimmerHomeContinueReadingWidget extends StatelessWidget {
  const ShimmerHomeContinueReadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Shimmer title row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Shimmer effect on title
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 24,
                width: 150,
                color: Colors.white,
              ),
            ),
            // Shimmer effect on icon
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Icon(
                Icons.arrow_forward_outlined,
                color: AppColors.orangeColor,
              ),
            )
          ],
        ),
        VSpace(10),
        // Shimmer effect on the horizontal book cards
        SizedBox(
          height: 230,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 5,
            // placeholder item count
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return shimmerBookCard();
            },
          ),
        )
      ],
    );
  }

  Widget shimmerBookCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Shimmer effect on the image container
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 160,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Shimmer effect on the title text
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 120,
            height: 12,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
