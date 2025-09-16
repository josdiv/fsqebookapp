// lib/features/search_books/presentation/pages/search_books_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/features/home/domain/entity/searched_entity.dart';
import 'package:foursquare_ebbok_app/features/home/presentation/cubits/home_cubit.dart';

import '../../../../../core/helper/navigate_to_book_details.dart';
import '../../../../profile/presentation/cubits/profile_cubit.dart';
import '../../../../status/presentation/cubits/status_cubit.dart';

class SearchBooksPage extends StatelessWidget {
  const SearchBooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          onChanged: (query) {
            context.read<HomeCubit>().getSearchedBookEvent(query);
          },
          decoration: const InputDecoration(
            hintText: 'Search for a book...',
            border: InputBorder.none,
          ),
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final isUserLoggedIn =
              context.read<StatusCubit>().state.model.isUserLoggedIn;
          final profile =
              context.read<ProfileCubit>().state.model.networkModel.profile;

          final model = state.model;
          final searchedModel = model.model2;

          if (searchedModel.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (searchedModel.loaded) {
            final books = searchedModel.searchedBooks;
            if (books.isEmpty) {
              return const Center(child: Text("No books found."));
            }
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (_, index) => GestureDetector(
                onTap: () => toBookDetails(
                  data: {
                    'id': books[index].bookId,
                    'userId': isUserLoggedIn ? profile.userId : '',
                  },
                  context: context,
                ),
                child: BookItem(book: books[index]),
              ),
            );
          } else if (searchedModel.hasError) {
            return Center(child: Text(searchedModel.error));
          }
          return const Center(child: Text("Start typing to search books..."));
        },
      ),
    );
  }
}

class BookItem extends StatelessWidget {
  final SearchedEntity book;

  const BookItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final areAllBooksFree =
        context.read<HomeCubit>().state.model.areAllBooksFree;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(book.bookImage,
              width: 50, height: 70, fit: BoxFit.cover),
        ),
        title: Text(book.bookTitle),
        subtitle: Text(
            "Price: ${areAllBooksFree ? "Free" : book.bookPrice} • Rating: ${book.bookRating}/5"),
      ),
    );
  }
}
