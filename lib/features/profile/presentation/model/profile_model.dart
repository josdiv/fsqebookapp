import 'package:equatable/equatable.dart';
import 'package:foursquare_ebbok_app/features/profile/domain/entity/profile_entity.dart';

class ProfileModel extends Equatable {
  const ProfileModel({
    required this.loading,
    required this.error,
    required this.loaded,
    required this.profile,
  });

  const ProfileModel.initial()
      : this(
          loading: false,
          error: '',
          loaded: false,
          profile: const ProfileEntity.initial(),
        );

  final bool loading;
  final String error;
  final bool loaded;
  final ProfileEntity profile;

  bool get hasError => error.isNotEmpty;

  ProfileModel copyWith({
    bool? loading,
    String? error,
    bool? loaded,
    ProfileEntity? profile,
  }) {
    return ProfileModel(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      loaded: loaded ?? this.loaded,
      profile: profile ?? this.profile,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        error,
        loaded,
        profile,
      ];
}
