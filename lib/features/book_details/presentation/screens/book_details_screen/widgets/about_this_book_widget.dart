import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../cubits/book_details_cubit.dart';

class AboutThisBookWidget extends StatelessWidget {
  const AboutThisBookWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookDetailsCubit, BookDetailsState>(
      builder: (context, state) {
        final model = state.model;
        final getBookDetailsModel = model.getBookDetailsModel;
        final entity = getBookDetailsModel.entity;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About this book",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: AppColors.blueColor,
              ),
            ),
            Text(
              entity.bookDescription,
            )
          ],
        );
      },
    );
  }
}



class AboutThisBookShimmerWidget extends StatelessWidget {
  const AboutThisBookShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 24,
            width: 150,
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 10),
          ),
        ),
        ...List.generate(5, (index) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 10,
              width: double.infinity,
              color: Colors.white,
            ),
          ),
        )),
      ],
    );
  }
}
