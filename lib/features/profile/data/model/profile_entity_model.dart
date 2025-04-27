import 'package:foursquare_ebbok_app/features/profile/domain/entity/profile_entity.dart';

class ProfileEntityModel extends ProfileEntity {
  const ProfileEntityModel({
    required super.userId,
    required super.userName,
    required super.userPhone,
    required super.userEmail,
    required super.profileImage,
    required super.createdAt,
  });

  factory ProfileEntityModel.fromMap(Map<String, dynamic> map) {
    return ProfileEntityModel(
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      userPhone: map['userPhone'] as String,
      userEmail: map['userEmail'] as String,
      profileImage: map['profileImage'] as String,
      createdAt: map['createdAt'] as String,
    );
  }
}
