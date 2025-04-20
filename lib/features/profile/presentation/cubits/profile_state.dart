part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState([this.model = const ProfileModel.initial()]);

  final ProfileModel model;

  @override
  List<Object> get props => [model];
}

final class ProfileInitial extends ProfileState {}

final class ProfileScreenState extends ProfileState {
  const ProfileScreenState(super.model);
}

final class EditProfileError extends ProfileState {
  const EditProfileError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

final class EditProfileLoading extends ProfileState {}

final class EditProfileSuccess extends ProfileState {}
