import 'package:foursquare_ebbok_app/features/profile/domain/entity/profile_entity.dart';

import '../../../../core/utils/typedefs/typedefs.dart';
import '../../../sign_up/data/model/user_entity_model.dart';

class ProfileEntityModel extends ProfileEntity {
  const ProfileEntityModel({
    required super.userId,
    required super.userName,
    required super.userPhone,
    required super.userEmail,
    required super.profileImage,
    required super.createdAt,
    required super.listDownloadBook,
    required super.listFavoriteBook,
    required super.listReadingBook,
  });

  factory ProfileEntityModel.fromMap(Map<String, dynamic> map) {
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
    final userProfile = map['userProfile'] as DataMap;

    return ProfileEntityModel(
      userId: userProfile['userId'].toString(),
      userName: userProfile['userName'] as String,
      userPhone: userProfile['userPhone'] as String,
      userEmail: userProfile['userEmail'] as String,
      profileImage: userProfile['profileImage'] as String,
      createdAt: userProfile['createdAt'] as String,
      listReadingBook: listReadingBook,
      listFavoriteBook: listFavoriteBook,
      listDownloadBook: listDownloadBook,
    );
  }
}
