import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:foursquare_ebbok_app/core/helper/common_loader.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/cubits/book_details_cubit.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/screens/book_details_screen/widgets/about_this_book_widget.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/screens/book_details_screen/widgets/book_details_header.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/screens/book_details_screen/widgets/book_details_icon.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/screens/book_details_screen/widgets/ratings_and_review.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/screens/book_details_screen/widgets/related_book_widget.dart';

import '../../../../../core/theme/app_colors.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key, required this.data});

  final DataMap data;

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BookDetailsCubit>().getBookDetailsEvent(widget.data);
  }

  @override
  void dispose() {
    super.dispose();
    Loader.hide();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookDetailsCubit, BookDetailsState>(
      listener: (context, state) {
        final model = state.model;
        final getBookDetailsModel = model.getBookDetailsModel;
        final event = context.read<BookDetailsCubit>();

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
        }
      },
      builder: (context, state) {
        final model = state.model;
        final getBookDetailsModel = model.getBookDetailsModel;
        // final event = context.read<BookDetailsCubit>();

        if (getBookDetailsModel.loading) {
          commonLoader(context);
        }
        return Scaffold(
          backgroundColor: Color(0xFFF5F5F5),
          appBar: AppBar(
            title: Text(
              "Details Page",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: AppColors.blueColor,
              ),
            ),
            centerTitle: false,
            foregroundColor: AppColors.blueColor,
            backgroundColor: Color(0xFFF5F5F5),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VSpace(40),
                BookDetailsHeader(),
                VSpace(20),
                BookDetailsIcon(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VSpace(20),
                        AboutThisBookWidget(),
                        VSpace(20),
                        RatingsAndReview(),
                        VSpace(20),
                        RelatedBookWidget(),
                        // VSpace(20),
                        // BookDetailsBuyBookButton(),
                        VSpace(50),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 50,
              child: BookDetailsBuyBookButton(),
            ),
          ),
        );
      },
    );
  }
}

class BookDetailsBuyBookButton extends StatelessWidget {
  const BookDetailsBuyBookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookDetailsCubit, BookDetailsState>(
      builder: (context, state) {
        final model = state.model;
        final getBookDetailsModel = model.getBookDetailsModel;
        final entity = getBookDetailsModel.entity;
        // final event = context.read<BookDetailsCubit>();

        return Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: AppColors.redColor,
              borderRadius: BorderRadius.circular(20)),
          alignment: Alignment.center,
          child: Text(
            entity.bookPrice.toLowerCase() == 'free'
                ? "READ BOOK"
                : "BUY BOOK",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
