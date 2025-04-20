import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/sign_up/domain/usecases/user_sign_up.dart';
import 'package:foursquare_ebbok_app/features/sign_up/presentation/models/sign_up_model.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required UserSignUp userSignUp,
  })  : _userSignUp = userSignUp,
        super(SignUpInitial());

  final UserSignUp _userSignUp;

  Future<void> signUpScreenEvent(SignUpModel model) async {
    emit(SignUpScreenState(model));
  }

  Future<void> userSignUpEvent(DataMap data) async {
    final model = state.model;

    emit(
      SignUpScreenState(
        model.copyWith(
          loading: true,
          error: '',
          loaded: false,
        ),
      ),
    );

    final result = await _userSignUp(data);

    result.fold(
      (l) => emit(
        SignUpScreenState(
          model.copyWith(
            loading: false,
            error: l.errorMessage,
            loaded: false,
          ),
        ),
      ),
      (r) => emit(
        SignUpScreenState(
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
