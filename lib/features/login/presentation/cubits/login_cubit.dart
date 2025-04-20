import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/login/domain/usecases/sign_in_with_google.dart';
import 'package:foursquare_ebbok_app/features/login/domain/usecases/sign_in_with_password.dart';
import 'package:foursquare_ebbok_app/features/login/presentation/models/login_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required SignInWithPassword signInWithPassword,
    required SignInWithGoogle signInWithGoogle,
  })  : _signInWithGoogle = signInWithGoogle,
        _signInWithPassword = signInWithPassword,
        super(LoginInitial());

  final SignInWithPassword _signInWithPassword;
  final SignInWithGoogle _signInWithGoogle;

  Future<void> signInWithPasswordEvent(DataMap data) async {
    final model = state.model;

    emit(
      LoginScreenState(
        model.copyWith(
          loading: true,
          error: '',
          loaded: false,
        ),
      ),
    );

    final result = await _signInWithPassword(data);

    result.fold(
      (l) => emit(
        LoginScreenState(
          model.copyWith(
            loading: false,
            error: l.errorMessage,
            loaded: false,
          ),
        ),
      ),
      (r) => emit(
        LoginScreenState(
          model.copyWith(
            loading: false,
            error: '',
            loaded: true,
            user: r,
          ),
        ),
      ),
    );
  }

  Future<void> signInWithGoogleEvent(DataMap data) async {
    final model = state.model;

    emit(
      LoginScreenState(
        model.copyWith(
          loading: true,
          error: '',
          loaded: false,
        ),
      ),
    );

    final result = await _signInWithGoogle(data);

    result.fold(
      (l) => emit(
        LoginScreenState(
          model.copyWith(
            loading: false,
            error: l.errorMessage,
            loaded: false,
          ),
        ),
      ),
      (r) => emit(
        LoginScreenState(
          model.copyWith(
            loading: false,
            error: '',
            loaded: true,
            user: r,
          ),
        ),
      ),
    );
  }
}
