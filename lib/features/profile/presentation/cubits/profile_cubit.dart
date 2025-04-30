import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/profile/domain/usecases/edit_user_profile.dart';
import 'package:foursquare_ebbok_app/features/profile/domain/usecases/get_user_profile.dart';
import 'package:foursquare_ebbok_app/features/profile/presentation/model/profile_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required GetUserProfile getUserProfile,
    required EditUserProfile editUserProfile,
  })  : _editUserProfile = editUserProfile,
        _getUserProfile = getUserProfile,
        super(ProfileInitial());

  final GetUserProfile _getUserProfile;
  final EditUserProfile _editUserProfile;

  Future<void> profileScreenEvent(ProfileModel model) async {
    emit(ProfileScreenState(model));
  }

  Future<void> editUserProfile(DataMap data) async {
    emit(EditProfileLoading(state.model));

    final result = await _editUserProfile(data);

    result.fold(
      (l) => emit(EditProfileError(l.errorMessage, state.model)),
      (r) => emit(
        EditProfileSuccess(state.model),
      ),
    );
  }

  Future<void> getUserProfileEvent(String email) async {
    final model = state.model;
    final networkModel = model.networkModel;

    emit(
      ProfileScreenState(
        model.copyWith(
          networkModel: networkModel.copyWith(
            loading: true,
            error: '',
            loaded: false,
          ),
        ),
      ),
    );

    final result = await _getUserProfile(email);

    result.fold(
      (l) => emit(
        ProfileScreenState(
          model.copyWith(
            networkModel: networkModel.copyWith(
              loading: false,
              error: l.errorMessage,
              loaded: false,
            ),
          ),
        ),
      ),
      (r) => emit(
        ProfileScreenState(
          model.copyWith(
            networkModel: networkModel.copyWith(
              loading: false,
              error: '',
              loaded: true,
              profile: r,
            ),
          ),
        ),
      ),
    );
  }
}
