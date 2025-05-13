import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/core/utils/open_book/open_book.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/entity/book.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/cubits/book_details_cubit.dart';
import 'package:foursquare_ebbok_app/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../core/helper/navigate_to_book_details.dart';
import '../../../../../book_details/domain/repository/download_repository.dart';
import '../../../../../sign_up/domain/entity/user_entity.dart';

class ModalContent extends StatefulWidget {
  const ModalContent({super.key});

  @override
  State<ModalContent> createState() => _ModalContentState();
}

class _ModalContentState extends State<ModalContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabs = ['Purchased', 'Favorite', 'Downloads', 'Reading'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildBookList<T>({
    required List<T> books,
    required String Function(T) getTitle,
    required String Function(T) getImage,
    required String Function(T) getId,
    bool download = false,
    required int index,
  }) {
    if (books.isEmpty) {
      return Center(
        child: Text(
          "Nothing here yet. 📚\nStart exploring!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      );
    }

    return BlocConsumer<BookDetailsCubit, BookDetailsState>(
      listener: (context, state) {
        final model = state.model;
        final readBook = model.readBookModel;
        final event = context.read<BookDetailsCubit>();

        if (readBook.loaded) {
          event.bookDetailsScreenEvent(
            model.copyWith(
              readBookModel: readBook.copyWith(
                loaded: false,
              ),
            ),
          );
          openBook(context, readBook.entity.bookUrl, '');
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: 12,
            runSpacing: 16,
            children: books.map((book) {
              final profile =
                  context.read<ProfileCubit>().state.model.networkModel.profile;
              return GestureDetector(
                onTap: (index == 0 || index == 1)
                    ? () => toBookDetails(
                          data: {
                            'id': getId(book),
                            'userId': profile.userId,
                          },
                          context: context,
                        )
                    : index == 3
                        ? () => context.read<BookDetailsCubit>().readBookEvent({
                              'userId': profile.userId,
                              'bookId': getId(book),
                            })
                        : () {
                            var myBook =
                                DownloadsRepository.getSingleBook(getId(book));

                            openBook(
                              context,
                              myBook.path,
                              allowStreaming: false,
                              getTitle(book),
                            );
                          },
                child: SizedBox(
                  width: 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: getImage(book),
                              height: 170,
                              width: 110,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  height: 170,
                                  width: 110,
                                  color: Colors.grey,
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                height: 170,
                                width: 110,
                                color: Colors.grey.shade300,
                                child: const Icon(Icons.broken_image, size: 40),
                              ),
                            ),
                          ),
                          if (download)
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  // Call your delete logic here
                                  DownloadsRepository.removeDownload(
                                      getId(book));
                                  setState(() {});
                                },
                                child: Container(
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        getTitle(book),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final profile = state.model.networkModel.profile;
        final favoriteBooks = profile.listFavoriteBook;
        // final downloadBooks = profile.listDownloadBook;
        final continueBooks = profile.listReadingBook;
        final purchasedBooks = profile.purchasedBooks;

        var downloads = DownloadsRepository.getDownloads();
        // print(downloads.length);

        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, -2),
              )
            ],
          ),
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                indicatorColor: Colors.red,
                labelColor: Colors.red,
                unselectedLabelColor: Colors.grey,
                tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
                onTap: (index) {
                  if (index == 2) {
                    setState(() {
                      downloads = DownloadsRepository.getDownloads();
                    });
                  }
                  if(index == 1) {
                    print("Favorite");
                  }
                },
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildBookList<PurchasedBookEntity>(
                      books: purchasedBooks,
                      getTitle: (book) => book.purchasedBookTitle,
                      getImage: (book) => book.purchasedBookImage,
                      getId: (book) => book.purchasedBookId,
                      index: 0,
                    ),
                    _buildBookList<FavouriteBookEntity>(
                      books: favoriteBooks,
                      getTitle: (book) => book.favoriteBookTitle,
                      getImage: (book) => book.favoriteBookImage,
                      getId: (book) => book.favoriteBookId,
                      index: 1,
                    ),
                    _buildBookList<Book>(
                      books: downloads,
                      getTitle: (book) => book.title,
                      getImage: (book) => book.coverUrl,
                      download: true,
                      getId: (book) => book.id,
                      index: 2,
                    ),
                    _buildBookList<ReadingBookEntity>(
                      books: continueBooks,
                      getTitle: (book) => book.readingBookTitle,
                      getImage: (book) => book.readingBookImage,
                      getId: (book) => book.readingBookId,
                      index: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
