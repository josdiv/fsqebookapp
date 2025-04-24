import 'package:equatable/equatable.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';

class SignUpScreenModel extends Equatable {
  const SignUpScreenModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.viewPassword,
    required this.acceptPolicy,
  });

  const SignUpScreenModel.initial()
      : this(
          name: '',
          email: '',
          password: '',
          phone: '',
          viewPassword: false,
          acceptPolicy: false,
        );

  final String name;
  final String email;
  final String password;
  final String phone;
  final bool viewPassword;
  final bool acceptPolicy;

  SignUpScreenModel addName(String e) => copyWith(name: e);

  String? validateName(String? e) => name.isEmpty ? 'Name is required' : null;

  //Email Validations
  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
    );
    return emailRegex.hasMatch(email);
  }

  SignUpScreenModel addEmail(String e) => copyWith(email: e);

  String? validateEmail(String? e) => email.isEmpty
      ? 'A valid email is required'
      : !isValidEmail(e ?? '')
          ? 'Invalid email'
          : null;

  //Password Validations
  SignUpScreenModel addPassword(String e) => copyWith(password: e);

  String? validatePassword(String? password) {
    if (password!.isEmpty) return 'Password is required';
    if (password.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  SignUpScreenModel togglePassword() => copyWith(viewPassword: !viewPassword);

  SignUpScreenModel togglePolicy() => copyWith(acceptPolicy: !acceptPolicy);

  bool get register =>
      name.isNotEmpty &&
      isValidEmail(email) &&
      validatePassword(password) == null &&
      acceptPolicy;

  DataMap get data => {
    'name': name,
    'email': email,
    'password': password,
    'phone': phone,
  };

  //Add Phone Number

  SignUpScreenModel addPhone(String e) => copyWith(phone: e);

  SignUpScreenModel copyWith({
    String? name,
    String? email,
    String? password,
    String? phone,
    bool? viewPassword,
    bool? acceptPolicy,
  }) {
    return SignUpScreenModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      viewPassword: viewPassword ?? this.viewPassword,
      acceptPolicy: acceptPolicy ?? this.acceptPolicy,
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        phone,
        viewPassword,
        acceptPolicy,
      ];
}
