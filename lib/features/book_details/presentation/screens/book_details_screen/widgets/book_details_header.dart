import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/cubits/book_details_cubit.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../core/misc/spacer.dart';
import '../../../../../home/presentation/cubits/home_cubit.dart';
import '../../../../../status/presentation/cubits/status_cubit.dart';

class BookDetailsHeader extends StatelessWidget {
  const BookDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookDetailsCubit, BookDetailsState>(
      builder: (context, state) {
        final areAllBooksFree =
            context.read<HomeCubit>().state.model.areAllBooksFree;
        final model = state.model;
        final getBookDetailsModel = model.getBookDetailsModel;
        final entity = getBookDetailsModel.entity;

        final isUserLoggedIn =
            context.read<StatusCubit>().state.model.isUserLoggedIn;
        final purchasedStatus = model.purchasedStatus;
        final showIcons = isUserLoggedIn && purchasedStatus;

        // final event = context.read<BookDetailsCubit>();

        return SizedBox(
          height: 180, // Give space for the image to float properly
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFEEEB),
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .46,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entity.bookTitle,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4E4B66),
                              ),
                            ),
                            Text(
                              "by ${entity.authorName}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF424242),
                              ),
                            ),
                            VSpace(5),
                            Row(
                              children: [
                                SvgPicture.asset("assets/icons/views.svg"),
                                HSpace(6),
                                Text(
                                  entity.postViewCount,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF424242),
                                  ),
                                ),
                              ],
                            ),
                            VSpace(5),
                            if (!showIcons)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 1,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.red,
                                ),
                                child: Text(
                                  areAllBooksFree ? 'Free' : entity.bookPrice,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -30,
                left: 20,
                child: Container(
                  height: 190.14,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(
                        entity.bookImg,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BookDetailsHeaderShimmer extends StatelessWidget {
  const BookDetailsHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              decoration: const BoxDecoration(
                color: Color(0xFFFFEEEB),
              ),
              child: Row(
                children: [
                  const Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .46,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(4, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: index == 3 ? 24 : 12,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -30,
            left: 20,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 190.14,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
