import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:shimmer/shimmer.dart';

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

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 12,
        runSpacing: 16,
        children: books.map((book) {
          return SizedBox(
            width: 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
          );
        }).toList(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final profile = state.model.networkModel.profile;
        final favoriteBooks = profile.listFavoriteBook;
        final downloadBooks = profile.listDownloadBook;
        final continueBooks = profile.listReadingBook;
        final purchasedBooks = profile.purchasedBooks;

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
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildBookList<PurchasedBookEntity>(
                      books: purchasedBooks,
                      getTitle: (book) => book.purchasedBookTitle,
                      getImage: (book) => book.purchasedBookImage,
                    ),
                    _buildBookList<FavouriteBookEntity>(
                      books: favoriteBooks,
                      getTitle: (book) => book.favoriteBookTitle,
                      getImage: (book) => book.favoriteBookImage,
                    ),
                    _buildBookList<DownloadedBookEntity>(
                      books: downloadBooks,
                      getTitle: (book) => book.downloadedBookTitle,
                      getImage: (book) => book.downloadedBookImage,
                    ),
                    _buildBookList<ReadingBookEntity>(
                      books: continueBooks,
                      getTitle: (book) => book.readingBookTitle,
                      getImage: (book) => book.readingBookImage,
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
