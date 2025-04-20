part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState([this.model = const LoginModel.initial()]);

  final LoginModel model;

  @override
  List<Object> get props => [model];
}

final class LoginInitial extends LoginState {}

final class LoginScreenState extends LoginState {
  const LoginScreenState(super.model);
}
