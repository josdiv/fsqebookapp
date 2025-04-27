import 'package:equatable/equatable.dart';

import '../../../../core/utils/typedefs/typedefs.dart';
import '../../../sign_up/domain/entity/user_entity.dart';

class LoginModel extends Equatable {
  const LoginModel({
    required this.networkModel,
    required this.screenModel,
  });

  const LoginModel.initial()
      : this(
          networkModel: const LoginNetworkModel.initial(),
          screenModel: const LoginScreenModel.initial(),
        );

  final LoginNetworkModel networkModel;
  final LoginScreenModel screenModel;

  LoginModel copyWith({
    LoginNetworkModel? networkModel,
    LoginScreenModel? screenModel,
  }) {
    return LoginModel(
      networkModel: networkModel ?? this.networkModel,
      screenModel: screenModel ?? this.screenModel,
    );
  }

  @override
  List<Object?> get props => [networkModel, screenModel];
}

class LoginNetworkModel extends Equatable {
  const LoginNetworkModel({
    required this.loading,
    required this.error,
    required this.loaded,
    required this.user,
  });

  const LoginNetworkModel.initial()
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

  LoginNetworkModel copyWith({
    bool? loading,
    String? error,
    bool? loaded,
    UserEntity? user,
  }) {
    return LoginNetworkModel(
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

class LoginScreenModel extends Equatable {
  const LoginScreenModel({
    required this.email,
    required this.password,
    required this.rememberMe,
    required this.viewPassword,
    required this.acceptPolicy,
  });

  const LoginScreenModel.initial()
      : this(
          email: '',
          password: '',
          rememberMe: false,
          viewPassword: false,
          acceptPolicy: false,
        );

  LoginScreenModel addEmail(String e) => copyWith(email: e);

  String? validateEmail(String? e) =>
      email.isEmpty ? 'A valid email is required' : null;

  //Password Validations
  LoginScreenModel addPassword(String e) => copyWith(password: e);

  String? validatePassword(String? password) {
    if (password!.isEmpty) return 'Password is required';
    // if (password.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  LoginScreenModel togglePassword() => copyWith(viewPassword: !viewPassword);

  LoginScreenModel togglePolicy() => copyWith(acceptPolicy: !acceptPolicy);

  LoginScreenModel toggleRememberMe() => copyWith(rememberMe: !rememberMe);

  bool get login =>
      email.isNotEmpty && validatePassword(password) == null && acceptPolicy;

  DataMap get data => {
        'email': email,
        'password': password,
      };

  final String email;
  final String password;
  final bool rememberMe;
  final bool viewPassword;
  final bool acceptPolicy;

  LoginScreenModel copyWith({
    String? email,
    String? password,
    bool? rememberMe,
    bool? viewPassword,
    bool? acceptPolicy,
  }) {
    return LoginScreenModel(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      viewPassword: viewPassword ?? this.viewPassword,
      acceptPolicy: acceptPolicy ?? this.acceptPolicy,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        rememberMe,
        viewPassword,
        acceptPolicy,
      ];
}
