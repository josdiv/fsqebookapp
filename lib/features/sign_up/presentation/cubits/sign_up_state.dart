part of 'sign_up_cubit.dart';

sealed class SignUpState extends Equatable {
  const SignUpState([this.model = const SignUpModel.initial()]);

  final SignUpModel model;

  @override
  List<Object> get props => [model];
}

final class SignUpInitial extends SignUpState {}

final class SignUpScreenState extends SignUpState {
  const SignUpScreenState(super.model);
}
