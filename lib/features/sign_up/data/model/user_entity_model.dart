import '../../../../../core/utils/typedefs/typedefs.dart';
import '../../domain/entity/user_entity.dart';

class UserEntityModel extends UserEntity {
  const UserEntityModel({
    required super.userId,
    required super.name,
    required super.email,
  });

  factory UserEntityModel.fromJson(DataMap json) {
    return UserEntityModel(
      userId: json['userId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }
}
