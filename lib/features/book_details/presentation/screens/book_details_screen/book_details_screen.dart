import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/cubits/book_details_cubit.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/screens/book_details_screen/widgets/about_this_book_widget.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/screens/book_details_screen/widgets/book_details_header.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/screens/book_details_screen/widgets/book_details_icon.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../core/theme/app_colors.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key, required this.id});

  final String id;

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BookDetailsCubit>().getBookDetailsEvent(widget.id);
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
        if (state is BookDetailsLoadedState) {
          Loader.hide();
        }

        if (state is BookDetailsErrorState) {
          Loader.hide();
        }
      },
      builder: (context, state) {
        if (state is BookDetailsLoadingState) {
          Loader.show(
            context,
            progressIndicator: LoadingAnimationWidget.threeArchedCircle(
              color: AppColors.purpleColor,
              size: 50,
            ),
          );
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
            child: state is BookDetailsLoadedState ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VSpace(40),
                BookDetailsHeader(),
                VSpace(20),
                BookDetailsIcon(),
                VSpace(20),
                AboutThisBookWidget()
              ],
            ) : state is BookDetailsErrorState ? Center(
              child: Text(state.error),
            ) : const SizedBox(),
          ),
        );
      },
    );
  }
}








