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

  final List<dynamic> listFavoriteBook;
  final List<dynamic> listReadingBook;
  final List<dynamic> listDownloadBook;
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
