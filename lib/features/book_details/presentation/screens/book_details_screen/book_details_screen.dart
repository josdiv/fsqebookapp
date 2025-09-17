import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:foursquare_ebbok_app/core/helper/common_loader.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';
import 'package:foursquare_ebbok_app/core/utils/open_book/open_book.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/cubits/book_details_cubit.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/screens/book_details_screen/widgets/about_this_book_widget.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/screens/book_details_screen/widgets/book_details_header.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/screens/book_details_screen/widgets/book_details_icon.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/screens/book_details_screen/widgets/download_progress_dialog.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/screens/book_details_screen/widgets/ratings_and_review.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/screens/book_details_screen/widgets/related_book_widget.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/screens/book_details_screen/widgets/write_review_widget.dart';
import 'package:foursquare_ebbok_app/features/buy_book/presentation/screens/buy_book_screen/buy_book_screen.dart';
import 'package:foursquare_ebbok_app/features/login/presentation/screens/login_screen/login_screen.dart';
import 'package:foursquare_ebbok_app/features/status/presentation/cubits/status_cubit.dart';

import '../../../../../core/services/download_service.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../home/presentation/cubits/home_cubit.dart';
import '../../../domain/repository/download_repository.dart';

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
        final toggleFavouriteModel = model.toggleFavouriteModel;
        final readBookModel = model.readBookModel;
        final reportBookModel = model.reportBookModel;
        final writeReviewModel = model.writeReviewModel;
        final downloadBookModel = model.downloadBookModel;
        final event = context.read<BookDetailsCubit>();

        if (downloadBookModel.hasError) {
          showSnackBar(context, downloadBookModel.error);
          event.bookDetailsScreenEvent(
            model.copyWith(
              downloadBookModel: downloadBookModel.copyWith(
                error: '',
              ),
            ),
          );
        }

        if (downloadBookModel.loaded) {
          final book = getBookDetailsModel.entity;
          final url = downloadBookModel.entity.bookUrl;
          final extension = downloadBookModel.entity.bookExtension;

          (() async {
            // First check if already downloaded
            if (DownloadsRepository.isBookDownloaded(book.bookId)) {
              if (context.mounted) {
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //       content:
                //           Text('"${book.bookTitle}" is already downloaded')),
                // );
                final myBook = DownloadsRepository.getSingleBook(book.bookId);

                openBook(
                    context,
                    myBook.path,
                    allowStreaming: false,
                    book.bookTitle);
              }
              return;
            }

            final progressController = StreamController<double>();

            showDownloadProgress(context, progressController.stream);

            try {
              final path = await DownloadService.downloadFile(
                url: url,
                fileName: '${book.bookId}.$extension', // e.g., '123.pdf'
                onProgress: (p) {
                  progressController.add(p);
                },
              );

              // Close the stream when done
              progressController.close();

              // Save download record
              await DownloadsRepository.saveDownload(book, path);

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Download successful!')),
                );
                Future.delayed(const Duration(seconds: 2), () {
                  //Open Downloaded Book
                  if (context.mounted) {
                    openBook(
                        context, path, allowStreaming: false, book.bookTitle);
                  }
                });
              }
            } catch (e) {
              // Close the stream on error as well
              progressController.close();
              if (context.mounted) {
                Navigator.pop(context); // Dismiss the progress dialog on error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Download failed: $e')),
                );
              }
            }
          })();

          event.bookDetailsScreenEvent(
            model.copyWith(
              downloadBookModel: downloadBookModel.copyWith(
                loaded: false,
              ),
            ),
          );
        }

        if (writeReviewModel.hasError) {
          showSnackBar(context, writeReviewModel.error);
          event.bookDetailsScreenEvent(
            model.copyWith(
              writeReviewModel: writeReviewModel.copyWith(
                error: '',
              ),
            ),
          );
        }

        if (writeReviewModel.loaded) {
          showSnackBar(context, 'Review sent successfully');
          Navigator.pop(context);
          event.bookDetailsScreenEvent(
            model.copyWith(
              writeReviewModel: writeReviewModel.copyWith(
                loaded: false,
              ),
            ),
          );
        }

        if (reportBookModel.hasError) {
          showSnackBar(context, reportBookModel.error);
          event.bookDetailsScreenEvent(
            model.copyWith(
              reportBookModel: reportBookModel.copyWith(
                error: '',
              ),
            ),
          );
        }

        if (reportBookModel.loaded) {
          showSnackBar(context, 'Report sent successfully');
          Navigator.pop(context);
          event.bookDetailsScreenEvent(
            model.copyWith(
              reportBookModel: reportBookModel.copyWith(
                loaded: false,
              ),
            ),
          );
        }

        // if (readBookModel.loading) {
        //   commonLoader(context);
        // }

        if (readBookModel.hasError) {
          // Loader.hide();
          showSnackBar(context, readBookModel.error);
          event.bookDetailsScreenEvent(
            model.copyWith(
              readBookModel: readBookModel.copyWith(
                error: '',
              ),
            ),
          );
        }

        // if (readBookModel.loaded) {
        //   print("Loaded Read 1");
        //   // Loader.hide();
        //   event.bookDetailsScreenEvent(
        //     model.copyWith(
        //       readBookModel: readBookModel.copyWith(
        //         loaded: false,
        //       ),
        //     ),
        //   );
        //   openBook(
        //     context,
        //     readBookModel.entity.bookUrl,
        //     getBookDetailsModel.entity.bookTitle,
        //   );
        //   // Navigator.push(
        //   //   context,
        //   //   MaterialPageRoute(
        //   //     builder: (context) => PdfViewerScreen(
        //   //       title: getBookDetailsModel.entity.bookTitle,
        //   //     ),
        //   //   ),
        //   // );
        // }

        if (toggleFavouriteModel.hasError) {
          showSnackBar(context, toggleFavouriteModel.error);
          event.bookDetailsScreenEvent(
            model.copyWith(
              favStatus: !model.favStatus,
              toggleFavouriteModel: toggleFavouriteModel.copyWith(
                error: '',
              ),
            ),
          );
        }

        if (toggleFavouriteModel.loaded) {
          showSnackBar(context, toggleFavouriteModel.message);
          event.bookDetailsScreenEvent(
            model.copyWith(
              // favStatus: model.favStatus,
              toggleFavouriteModel: toggleFavouriteModel.copyWith(
                loaded: false,
              ),
            ),
          );
        }

        if (getBookDetailsModel.loaded) {
          // Loader.hide();
          event.bookDetailsScreenEvent(
            model.copyWith(
              getBookDetailsModel: getBookDetailsModel.copyWith(
                loaded: false,
              ),
            ),
          );
        }

        if (getBookDetailsModel.hasError) {
          // Loader.hide();
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
        final loading = getBookDetailsModel.loading;
        // final event = context.read<BookDetailsCubit>();

        // if (getBookDetailsModel.loading) {
        //   commonLoader(context);
        // }
        final isUserLoggedIn =
            context.read<StatusCubit>().state.model.isUserLoggedIn;
        final purchasedStatus = model.purchasedStatus;

        final areAllBooksFree =
            context.read<HomeCubit>().state.model.areAllBooksFree;

        final showIcons =
            (isUserLoggedIn && purchasedStatus) || areAllBooksFree;

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
                loading ? BookDetailsHeaderShimmer() : BookDetailsHeader(),
                VSpace(20),
                if (showIcons)
                  loading ? BookDetailsIconShimmer() : BookDetailsIcon(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VSpace(20),
                        loading
                            ? AboutThisBookShimmerWidget()
                            : AboutThisBookWidget(),
                        VSpace(20),
                        loading
                            ? RatingsAndReviewShimmer()
                            : RatingsAndReview(),
                        if (showIcons)
                          loading
                              ? WriteReviewShimmerWidget()
                              : WriteReviewWidget(),
                        VSpace(20),
                        loading ? RelatedBookShimmer() : RelatedBookWidget(),
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
          bottomNavigationBar: showIcons
              ? null
              : Padding(
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
    final isUserLoggedIn =
        context.read<StatusCubit>().state.model.isUserLoggedIn;
    final areAllBooksFree =
        context.read<HomeCubit>().state.model.areAllBooksFree;

    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              isUserLoggedIn ? BuyBookScreen() : LoginScreen(),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: AppColors.redColor, borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        child: Text(
          areAllBooksFree ? "READ BOOK" : "BUY BOOK",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
