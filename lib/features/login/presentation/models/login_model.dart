import 'package:equatable/equatable.dart';

import '../../../sign_up/domain/entity/user_entity.dart';

class LoginModel extends Equatable {
  const LoginModel({
    required this.loading,
    required this.error,
    required this.loaded,
    required this.user,
  });

  const LoginModel.initial()
      : this(
    loading: false,
    error: '',
    loaded: false,
    user: const UserEntity.initial(),
  );

  final bool loading;
  final String error;
  final bool loaded;
  final UserEntity user;

  bool get hasError => error.isNotEmpty;

  LoginModel copyWith({
    bool? loading,
    String? error,
    bool? loaded,
    UserEntity? user,
  }) {
    return LoginModel(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      loaded: loaded ?? this.loaded,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
    loading,
    error,
    loaded,
    user,
  ];
}