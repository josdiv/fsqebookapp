import 'package:equatable/equatable.dart';

import '../../../sign_up/domain/entity/user_entity.dart';

class ProfileEntity extends Equatable {
  const ProfileEntity({
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.userEmail,
    required this.profileImage,
    required this.createdAt,
    required this.listFavoriteBook,
    required this.listReadingBook,
    required this.listDownloadBook,
    required this.purchasedBooks,
  });

  final List<FavouriteBookEntity> listFavoriteBook;
  final List<ReadingBookEntity> listReadingBook;
  final List<DownloadedBookEntity> listDownloadBook;
  final List<PurchasedBookEntity> purchasedBooks;
  final String userId;
  final String userName;
  final String? userPhone;
  final String userEmail;
  final String profileImage;
  final String createdAt;

  const ProfileEntity.initial()
      : this(
          userId: '',
          userName: '',
          userPhone: '',
          userEmail: '',
          profileImage: '',
          createdAt: '',
          listReadingBook: const [],
          listDownloadBook: const [],
          listFavoriteBook: const [],
          purchasedBooks: const [],
        );

  bool get hasReadingBooks => listReadingBook.isNotEmpty;

  @override
  List<Object?> get props => throw [
        userId,
        userName,
        userPhone,
        userEmail,
        profileImage,
        createdAt,
        listDownloadBook,
        listFavoriteBook,
        listReadingBook,
        purchasedBooks,
      ];
}
