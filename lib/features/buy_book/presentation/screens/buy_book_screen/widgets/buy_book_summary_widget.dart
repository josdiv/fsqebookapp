import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/cubits/book_details_cubit.dart';

import '../../../../../../core/misc/spacer.dart';

class BuyBookSummaryWidget extends StatelessWidget {
  const BuyBookSummaryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookDetailsCubit, BookDetailsState>(
      builder: (context, state) {
        final book = state.model.getBookDetailsModel.entity;

        return Container(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.deepPurpleAccent.withOpacity(.4),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                height: 20,
                width: 20,
                // padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  border: Border.all(width: 2, color: Colors.white),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              HSpace(10),
              Expanded(
                child: Text(
                  book.bookTitle,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              HSpace(20),
              Expanded(
                child: FittedBox(
                  child: Text(
                    "${book.bookPrice}/NGN",
                    // overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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