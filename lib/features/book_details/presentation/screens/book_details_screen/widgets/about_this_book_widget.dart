import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../cubits/book_details_cubit.dart';

class AboutThisBookWidget extends StatelessWidget {
  const AboutThisBookWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookDetailsCubit, BookDetailsState>(
      builder: (context, state) {
        return state is BookDetailsLoadedState ? Column(
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
              state.entity.bookDescription,
            )
          ],
        ) : SizedBox();
      },
    );
  }
}