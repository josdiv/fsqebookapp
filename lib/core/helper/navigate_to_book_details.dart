import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/cubits/book_details_cubit.dart';

import '../../features/book_details/presentation/screens/book_details_screen/book_details_screen.dart';
import 'common_loader.dart';

void toBookDetails({required DataMap data, required BuildContext context}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsScreen(data: data),
      ),
    );

void toBookDetailsV2({required DataMap data, required BuildContext context}) {
  context.read<BookDetailsCubit>().getBookDetailsEvent(data);
  BlocListener<BookDetailsCubit, BookDetailsState>(
    listener: (context, state) {
      final model = state.model;
      final getBookDetailsModel = model.getBookDetailsModel;
      final event = context.read<BookDetailsCubit>();

      if (getBookDetailsModel.loading) {
        print('loading');
        commonLoader(context);
      }

      if (getBookDetailsModel.loaded && Loader.isShown) {
        Loader.hide();
        event.bookDetailsScreenEvent(
          model.copyWith(
            getBookDetailsModel: getBookDetailsModel.copyWith(
              loaded: false,
            ),
          ),
        );
      }

      if (getBookDetailsModel.hasError && Loader.isShown) {
        Loader.hide();
        event.bookDetailsScreenEvent(
          model.copyWith(
            getBookDetailsModel: getBookDetailsModel.copyWith(
              error: '',
            ),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailsScreen(data: data),
          ),
        );
      }
    },
    child: Text('data'),
  );
}
