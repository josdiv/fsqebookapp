part of 'settings_cubit.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

final class SettingsInitial extends SettingsState {}

final class AboutUsLoadingState extends SettingsState {}
final class AboutUsErrorState extends SettingsState {
  const AboutUsErrorState(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
final class AboutUsLoadedState extends SettingsState {
  const AboutUsLoadedState(this.aboutUs);

  final String aboutUs;

  @override
  List<Object> get props => [aboutUs];
}


final class TermsOfUseLoadingState extends SettingsState {}
final class TermsOfUseErrorState extends SettingsState {
  const TermsOfUseErrorState(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
final class TermsOfUseLoadedState extends SettingsState {
  const TermsOfUseLoadedState(this.terms);

  final String terms;

  @override
  List<Object> get props => [terms];
}

final class RequestDeleteLoadingState extends SettingsState {}
final class RequestDeleteErrorState extends SettingsState {
  const RequestDeleteErrorState(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
final class RequestDeleteLoadedState extends SettingsState {
  const RequestDeleteLoadedState();
}