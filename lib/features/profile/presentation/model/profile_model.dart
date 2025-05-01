import 'package:equatable/equatable.dart';
import 'package:foursquare_ebbok_app/features/profile/domain/entity/profile_entity.dart';

import '../../../../core/utils/typedefs/typedefs.dart';

class ProfileModel extends Equatable {
  const ProfileModel({
    required this.networkModel,
    required this.screenModel,
  });

  const ProfileModel.initial()
      : this(
          networkModel: const ProfileNetworkModel.initial(),
          screenModel: const ProfileScreenModel.initial(),
        );

  final ProfileNetworkModel networkModel;
  final ProfileScreenModel screenModel;

  ProfileModel copyWith({
    ProfileNetworkModel? networkModel,
    ProfileScreenModel? screenModel,
  }) {
    return ProfileModel(
      networkModel: networkModel ?? this.networkModel,
      screenModel: screenModel ?? this.screenModel,
    );
  }

  @override
  List<Object?> get props => [networkModel, screenModel];
}

class ProfileNetworkModel extends Equatable {
  const ProfileNetworkModel({
    required this.loading,
    required this.error,
    required this.loaded,
    required this.profile,
  });

  const ProfileNetworkModel.initial()
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

  ProfileNetworkModel copyWith({
    bool? loading,
    String? error,
    bool? loaded,
    ProfileEntity? profile,
  }) {
    return ProfileNetworkModel(
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

class ProfileScreenModel extends Equatable {
  const ProfileScreenModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.viewPassword,
    required this.profilePic,
  });

  const ProfileScreenModel.initial()
      : this(
          name: '',
          email: '',
          password: '',
          phone: '',
          viewPassword: false,
          profilePic: '',
        );

  final String name;
  final String email;
  final String password;
  final String phone;
  final bool viewPassword;
  final String profilePic;

  ProfileScreenModel addName(String e) => copyWith(name: e);

  String? validateName(String? e) => name.isEmpty ? 'Name is required' : null;

  //Password Validations
  ProfileScreenModel addPassword(String e) => copyWith(password: e);

  String? validatePassword(String? password) {
    // if (password!.isEmpty) return 'Password is required';
    if (password!.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  ProfileScreenModel togglePassword() => copyWith(viewPassword: !viewPassword);

  bool get register => name.isNotEmpty;

  DataMap get data => {
        'name': name,
        'email': email,
        if (password.length >= 6) 'password': password,
        if (phone.isNotEmpty) 'phone': phone,
        if (profilePic.isNotEmpty) 'userimage': profilePic,
      };

  //Add Phone Number

  ProfileScreenModel addPhone(String e) => copyWith(phone: e);

  ProfileScreenModel copyWith({
    String? name,
    String? email,
    String? password,
    String? phone,
    bool? viewPassword,
    String? profilePic,
  }) {
    return ProfileScreenModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      viewPassword: viewPassword ?? this.viewPassword,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        phone,
        viewPassword,
        profilePic,
      ];
}
