import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  const ProfileEntity({
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.userEmail,
    required this.profileImage,
    required this.createdAt,
  });

  final String userId;
  final String userName;
  final String userPhone;
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
        );

  @override
  List<Object?> get props => throw [
        userId,
        userName,
        userPhone,
        userEmail,
        profileImage,
        createdAt,
      ];
}
