import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.userId,
    required this.name,
    required this.email,
  });

  const UserEntity.initial()
      : this(
          userId: '',
          name: '',
          email: '',
        );

  final String userId;
  final String name;
  final String email;

  @override
  List<Object?> get props => [userId, name, email];
}
