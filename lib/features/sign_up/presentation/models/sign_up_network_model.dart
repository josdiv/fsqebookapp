import 'package:equatable/equatable.dart';
import 'package:foursquare_ebbok_app/features/sign_up/domain/entity/user_entity.dart';

class SignUpNetworkModel extends Equatable {
  const SignUpNetworkModel({
    required this.loading,
    required this.error,
    required this.loaded,
    required this.user,
  });

  const SignUpNetworkModel.initial()
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

  SignUpNetworkModel copyWith({
    bool? loading,
    String? error,
    bool? loaded,
    UserEntity? user,
  }) {
    return SignUpNetworkModel(
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