
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
    final profileDetails = ProfileDetailsModel.fromMap(map['profileDetail'] as DataMap);

    return UserEntityModel(
      listFavoriteBook: map['listFavoriteBook'] as List<dynamic>,
      listReadingBook: map['listReadingBook'] as List<dynamic>,
      listDownloadBook: map['listDownloadBook'] as List<dynamic>,
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
