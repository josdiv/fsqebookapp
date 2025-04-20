import 'package:equatable/equatable.dart';
import 'package:foursquare_ebbok_app/features/sign_up/domain/entity/user_entity.dart';

class SignUpModel extends Equatable {
  const SignUpModel({
    required this.loading,
    required this.error,
    required this.loaded,
    required this.user,
  });

  const SignUpModel.initial()
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

  SignUpModel copyWith({
    bool? loading,
    String? error,
    bool? loaded,
    UserEntity? user,
  }) {
    return SignUpModel(
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