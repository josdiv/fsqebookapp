import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foursquare_ebbok_app/core/ui/widgets/default_button.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/cubits/book_details_cubit.dart';
import 'package:foursquare_ebbok_app/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:foursquare_ebbok_app/features/status/presentation/cubits/status_cubit.dart';

import '../../../../../../core/misc/spacer.dart';
import '../../../../../login/presentation/screens/login_screen/login_screen.dart';

class BookDetailsIcon extends StatelessWidget {
  const BookDetailsIcon({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookDetailsCubit, BookDetailsState>(
      builder: (context, state) {
        final model = state.model;
        final favStatus = model.favStatus;
        final event = context.read<BookDetailsCubit>();
        final userId = context
            .read<ProfileCubit>()
            .state
            .model
            .networkModel
            .profile
            .userId;
        final book = model.getBookDetailsModel.entity;

        return Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            iconWidget(
              icon: favStatus ? "favourite_filled" : "favourite",
              text: "Favourite",
              context: context,
              onTap: () {
                event.bookDetailsScreenEvent(
                  model.copyWith(
                    favStatus: !favStatus,
                  ),
                );
                Future.delayed(Duration(seconds: 2), () {
                  event.toggleFavouriteEvent({
                    "userId": userId,
                    "bookId": book.bookId,
                  });
                });
              },
            ),
            spacer(),
            iconWidget(
              icon: "Download",
              text: "Download",
              context: context,
            ),
            spacer(),
            iconWidget(
              icon: "read",
              text: "Read",
              context: context,
              onTap: () => event.readBookEvent({
                "userId": userId,
                "bookId": book.bookId,
              }),
            ),
            spacer(),
            iconWidget(
              icon: "Report",
              text: "Report",
              context: context,
              onTap: () => showReportBookBottomSheet(
                context: context,
                userId: userId,
                bookId: book.bookId,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget spacer() => Container(
        height: 30,
        width: 1,
        color: Color(0xFF4E4B66),
      );

  Widget iconWidget({
    required String icon,
    required String text,
    required BuildContext context,
    VoidCallback? onTap,
  }) {
    final isUserLoggedIn =
        context.read<StatusCubit>().state.model.isUserLoggedIn;

    return Expanded(
      child: InkWell(
        onTap: isUserLoggedIn
            ? onTap
            : () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                ),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/icons/$icon.svg',
              height: 25,
            ),
            VSpace(10),
            Text(
              text,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF424242),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void showReportBookBottomSheet({
  required BuildContext context,
  required String userId,
  required String bookId,
}) {
  final formKey = GlobalKey<FormState>();
  final reportController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      final screenHeight = MediaQuery.of(context).size.height;
      return BlocBuilder<BookDetailsCubit, BookDetailsState>(
        builder: (context, state) {
          final model = state.model;
          final reportBookModel = model.reportBookModel;

          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus(); // ✅ Dismiss keyboard on tap outside
            },
            behavior: HitTestBehavior.opaque, // ensures it catches taps on empty space
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom * .6,
              ),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: screenHeight * 0.5, // 50% of screen
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Text(
                            'Report Book',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 16),
                        Form(
                          key: formKey,
                          child: TextFormField(
                            controller: reportController,
                            maxLines: 3,
                            // autofocus: true,
                            decoration: InputDecoration(
                              labelText: 'Report Book',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              alignLabelWithHint: true,
                              suffixIcon: reportController.text.isNotEmpty
                                  ? IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  reportController.clear();
                                  if (formKey.currentState != null) {
                                    formKey.currentState!.validate();
                                  }
                                },
                              )
                                  : null,
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter a report';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              if (formKey.currentState != null) {
                                formKey.currentState!.validate();
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        DefaultButton(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              // Process the report here
                              // Navigator.pop(context); // Close the bottom sheet
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   SnackBar(content: Text('Report submitted')),
                              // );
                              context.read<BookDetailsCubit>().reportBookEvent({
                                'userId': userId,
                                'bookId': bookId,
                                'reasons': reportController.text.trim(),
                              });
                            }
                          },
                          opacity: true,
                          loading: reportBookModel.loading,
                          text: 'Submit',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}




/*DefaultButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          // Process the report here
                          // Navigator.pop(context); // Close the bottom sheet
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text('Report submitted')),
                          // );
                          context.read<BookDetailsCubit>().reportBookEvent({
                            'userId': userId,
                            'bookId': bookId,
                            'reasons': reportController.text.trim(),
                          });
                        }
                      },
                      opacity: true,
                      loading: reportBookModel.loading,
                      text: 'Submit',
                    ),*/