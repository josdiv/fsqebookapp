import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/cubits/book_details_cubit.dart';

import '../../../../../../core/misc/spacer.dart';

class BookDetailsHeader extends StatelessWidget {
  const BookDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookDetailsCubit, BookDetailsState>(
      builder: (context, state) {
        return (state is BookDetailsLoadedState)
            ? SizedBox(
                height: 180, // Give space for the image to float properly
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 5),
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
                                    state.entity.bookTitle,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF4E4B66),
                                    ),
                                  ),
                                  Text(
                                    "by ${state.entity.authorName}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF424242),
                                    ),
                                  ),
                                  VSpace(5),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/icons/views.svg"),
                                      HSpace(6),
                                      Text(
                                        state.entity.postViewCount,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF424242),
                                        ),
                                      ),
                                    ],
                                  ),
                                  VSpace(5),
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
                                      state.entity.bookPrice,
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
                              state.entity.bookImg,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox();
      },
    );
  }
}
