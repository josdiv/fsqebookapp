import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.listFavoriteBook,
    required this.listReadingBook,
    required this.listDownloadBook,
    required this.profileDetails,
  });

  const UserEntity.initial()
      : this(
          listDownloadBook: const [],
          listFavoriteBook: const [],
          listReadingBook: const [],
          profileDetails: const ProfileDetails.initial(),
        );

  final List<FavouriteBookEntity> listFavoriteBook;
  final List<ReadingBookEntity> listReadingBook;
  final List<DownloadedBookEntity> listDownloadBook;
  final ProfileDetails profileDetails;

  @override
  List<Object?> get props => [
        listFavoriteBook,
        listReadingBook,
        listDownloadBook,
        profileDetails,
      ];
}

class ProfileDetails extends Equatable {
  final String userId;
  final String name;
  final String email;
  final String phone;
  final String profileImage;
  final String registereDate;

  const ProfileDetails.initial()
      : this(
          userId: '',
          name: '',
          email: '',
          phone: '',
          profileImage: '',
          registereDate: '',
        );

  const ProfileDetails({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.profileImage,
    required this.registereDate,
  });

  @override
  List<Object?> get props => [
        userId,
        name,
        email,
        phone,
        profileImage,
        registereDate,
      ];
}

class FavouriteBookEntity extends Equatable {
  const FavouriteBookEntity({
    required this.favoriteBookId,
    required this.favoriteBookTitle,
    required this.favoriteBookImage,
  });

  final String favoriteBookId;
  final String favoriteBookTitle;
  final String favoriteBookImage;

  @override
  List<Object?> get props => [
        favoriteBookId,
        favoriteBookTitle,
        favoriteBookImage,
      ];
}

class ReadingBookEntity extends Equatable {
  const ReadingBookEntity({
    required this.readingBookId,
    required this.readingBookTitle,
    required this.readingBookImage,
  });

  final String readingBookId;
  final String readingBookTitle;
  final String readingBookImage;

  @override
  List<Object?> get props => [
        readingBookId,
        readingBookTitle,
        readingBookImage,
      ];
}

class DownloadedBookEntity extends Equatable {
  const DownloadedBookEntity({
    required this.downloadedBookId,
    required this.downloadedBookTitle,
    required this.downloadedBookImage,
  });

  final String downloadedBookId;
  final String downloadedBookTitle;
  final String downloadedBookImage;

  @override
  List<Object?> get props => [
        downloadedBookId,
        downloadedBookTitle,
        downloadedBookImage,
      ];
}
