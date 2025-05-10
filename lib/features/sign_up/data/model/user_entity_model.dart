
import '../../../../../core/utils/typedefs/typedefs.dart';
import '../../domain/entity/user_entity.dart';

class UserEntityModel extends UserEntity {
  const UserEntityModel({
    required super.listFavoriteBook,
    required super.listReadingBook,
    required super.listDownloadBook,
    required super.profileDetails,
  });

  factory UserEntityModel.fromJson(Map<String, dynamic> map) {
    final profileDetails =
        ProfileDetailsModel.fromMap(map['profileDetail'] as DataMap);

    final dynamicFavoriteBook = map['listFavoriteBook'] as List<dynamic>;
    final dynamicReadingBook = map['listReadingBook'] as List<dynamic>;
    final dynamicDownloadBook = map['listDownloadBook'] as List<dynamic>;

    final listFavoriteBook = dynamicFavoriteBook
        .map((e) => FavouriteBookEntityModel.fromMap(e as DataMap))
        .toList();

    final listReadingBook = dynamicReadingBook
        .map((e) => ReadingBookEntityModel.fromMap(e as DataMap))
        .toList();

    final listDownloadBook = dynamicDownloadBook
        .map((e) => DownloadedBookEntityModel.fromMap(e as DataMap))
        .toList();

    return UserEntityModel(
      listFavoriteBook: listFavoriteBook,
      listReadingBook: listReadingBook,
      listDownloadBook: listDownloadBook,
      profileDetails: profileDetails,
    );
  }
}

class ProfileDetailsModel extends ProfileDetails {
  const ProfileDetailsModel({
    required super.userId,
    required super.name,
    required super.email,
    required super.phone,
    required super.profileImage,
    required super.registereDate,
  });

  factory ProfileDetailsModel.fromMap(Map<String, dynamic> map) {
    return ProfileDetailsModel(
      userId: (map['userId'] as int).toString(),
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      profileImage: map['profileImage'] as String,
      registereDate: map['registereDate'] as String,
    );
  }
}

class FavouriteBookEntityModel extends FavouriteBookEntity {
  const FavouriteBookEntityModel({
    required super.favoriteBookId,
    required super.favoriteBookTitle,
    required super.favoriteBookImage,
  });

  factory FavouriteBookEntityModel.fromMap(Map<String, dynamic> map) {
    return FavouriteBookEntityModel(
      favoriteBookId: map['favoriteBookId'].toString(),
      favoriteBookTitle: map['favoriteBookTitle'] as String,
      favoriteBookImage: map['favoriteBookImage'] as String,
    );
  }
}

class ReadingBookEntityModel extends ReadingBookEntity {
  const ReadingBookEntityModel({
    required super.readingBookId,
    required super.readingBookTitle,
    required super.readingBookImage,
  });

  factory ReadingBookEntityModel.fromMap(Map<String, dynamic> map) {
    return ReadingBookEntityModel(
      readingBookId: map['readingBookId'].toString(),
      readingBookTitle: map['readingBookTitle'] as String,
      readingBookImage: map['readingBookImage'] as String,
    );
  }
}

class DownloadedBookEntityModel extends DownloadedBookEntity {
  const DownloadedBookEntityModel({
    required super.downloadedBookId,
    required super.downloadedBookTitle,
    required super.downloadedBookImage,
  });

  factory DownloadedBookEntityModel.fromMap(Map<String, dynamic> map) {
    return DownloadedBookEntityModel(
      downloadedBookId: map['downloadedBookId'].toString(),
      downloadedBookTitle: map['downloadedBookTitle'] as String,
      downloadedBookImage: map['downloadedBookImage'] as String,
    );
  }
}

class PurchasedBookEntityModel extends PurchasedBookEntity {
  const PurchasedBookEntityModel({
    required super.purchasedBookId,
    required super.purchasedBookTitle,
    required super.purchasedBookImage,
  });

  factory PurchasedBookEntityModel.fromMap(Map<String, dynamic> map) {
    return PurchasedBookEntityModel(
      purchasedBookId: map['purchasedBookId'].toString(),
      purchasedBookTitle: map['purchasedBookTitle'] as String,
      purchasedBookImage: map['purchasedBookImage'] as String,
    );
  }
}
