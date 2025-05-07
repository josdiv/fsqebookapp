import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foursquare_ebbok_app/core/helper/navigate_to_book_details.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';
import 'package:foursquare_ebbok_app/features/authors/presentation/cubits/authors_cubit.dart';
import 'package:foursquare_ebbok_app/features/latest/presentation/screens/widgets/latest_card_widget.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../profile/presentation/cubits/profile_cubit.dart';
import '../../../../status/presentation/cubits/status_cubit.dart';

class AuthorDetailsScreen extends StatelessWidget {
  const AuthorDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          "Author Info",
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VSpace(10),
              AuthorInfoWidget(),
              VSpace(20),
              AuthorBooksWidget()
            ],
          ),
        ),
      ),
    );
  }
}

class AuthorBooksWidget extends StatelessWidget {
  const AuthorBooksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorsCubit, AuthorsState>(
      builder: (context, state) {
        final isUserLoggedIn =
            context.read<StatusCubit>().state.model.isUserLoggedIn;
        final profile =
            context.read<ProfileCubit>().state.model.networkModel.profile;
        final authorBooks =
            state.model.getSingleAuthorNetworkModel.author.authorBooks;
        return authorBooks.isEmpty
            ? Center(child: Text("No Author Books"))
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Author Books",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: AppColors.blueColor,
              ),
            ),
            const VSpace(20),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7, // Adjust as needed
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 10,
                  childAspectRatio: (MediaQuery.of(context).size.width / 2) / 400,
                ),
                itemCount: authorBooks.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      toBookDetails(
                        data: {
                          'id': authorBooks[index].bookId,
                          'userId': isUserLoggedIn ? profile.userId : '',
                        },
                        context: context,
                      );
                    },
                    child: LatestCardWidget(
                      title: authorBooks[index].bookTitle,
                      url: authorBooks[index].bookImage,
                      rating: double.parse(authorBooks[index].bookRating),
                      price: authorBooks[index].bookPrice,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class AuthorInfoWidget extends StatelessWidget {
  const AuthorInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorsCubit, AuthorsState>(
      builder: (context, state) {
        final author = state.model.getSingleAuthorNetworkModel.author;

        return Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFFFEEEB),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(author.authorImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  HSpace(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          author.authorName,
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4E4B66),
                          ),
                        ),
                        VSpace(5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/Youtube.svg",
                              height: 20,
                              width: 20,
                            ),
                            HSpace(10),
                            SvgPicture.asset(
                              "assets/icons/Fb.svg",
                              height: 20,
                              width: 20,
                            ),
                            HSpace(10),
                            SvgPicture.asset(
                              "assets/icons/Insta.svg",
                              height: 20,
                              width: 20,
                            ),
                            HSpace(10),
                            SvgPicture.asset(
                              "assets/icons/Web.svg",
                              height: 20,
                              width: 20,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              VSpace(10),
              Text(
                author.authorInfo,
                style: TextStyle(
                  height: 1.65,
                  fontSize: 15,
                  color: Color(0xFF424242),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
