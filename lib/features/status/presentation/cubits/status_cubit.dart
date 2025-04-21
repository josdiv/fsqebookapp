import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/features/status/domain/usecases/get_user_login_status.dart';
import 'package:foursquare_ebbok_app/features/status/domain/usecases/set_user_login_status.dart';
import 'package:foursquare_ebbok_app/features/status/presentation/models/status_model.dart';

part 'status_state.dart';

class StatusCubit extends Cubit<StatusState> {
  StatusCubit({
    required GetUserLoginStatus getUserLoginStatus,
    required SetUserLoginStatus setUserLoginStatus,
  })  : _setUserLoginStatus = setUserLoginStatus,
        _getUserLoginStatus = getUserLoginStatus,
        super(StatusInitial());

  final GetUserLoginStatus _getUserLoginStatus;
  final SetUserLoginStatus _setUserLoginStatus;

  Future<void> statusScreenEvent(StatusModel model) async {
    emit(StatusScreenModel(model));
  }

  Future<void> getUserLoginStatusEvent() async {
    final model = state.model;
    final result = await _getUserLoginStatus();

    result.fold(
      (l) => emit(
        StatusScreenModel(
          model.copyWith(
            isUserLoggedIn: false,
          ),
        ),
      ),
      (r) => emit(
        StatusScreenModel(
          model.copyWith(
            isUserLoggedIn: r,
          ),
        ),
      ),
    );
  }

  Future<void> setUserLoginStatusEvent(bool status) async {
    final model = state.model;
    final result = await _setUserLoginStatus(status);

    result.fold(
      (l) => emit(
        StatusScreenModel(
          model.copyWith(
            isUserLoggedIn: false,
          ),
        ),
      ),
      (r) => emit(
        StatusScreenModel(
          model.copyWith(),
        ),
      ),
    );
  }
}
