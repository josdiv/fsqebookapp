
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/features/settings/domain/usecases/get_about_us.dart';
import 'package:foursquare_ebbok_app/features/settings/domain/usecases/get_terms_of_use.dart';
import 'package:foursquare_ebbok_app/features/settings/domain/usecases/request_account_deletion.dart';

import '../../../../core/utils/typedefs/typedefs.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    required GetAboutUs getAboutUs,
    required GetTermsOfUse getTermsOfUse,
    required RequestAccountDeletion requestAccountDeletion,
  })  : _getAboutUs = getAboutUs,
        _getTermsOfUse = getTermsOfUse,
        _requestAccountDeletion = requestAccountDeletion,
        super(SettingsInitial());

  final GetAboutUs _getAboutUs;
  final GetTermsOfUse _getTermsOfUse;
  final RequestAccountDeletion _requestAccountDeletion;

  Future<void> getAboutUsEvent() async {
    emit(AboutUsLoadingState());

    final result = await _getAboutUs();

    result.fold(
      (l) => emit(
        AboutUsErrorState(l.errorMessage),
      ),
      (r) => emit(
        AboutUsLoadedState(r),
      ),
    );
  }

  Future<void> getTermsOfUseEvent() async {
    emit(TermsOfUseLoadingState());

    final result = await _getTermsOfUse();

    result.fold(
          (l) => emit(
        TermsOfUseErrorState(l.errorMessage),
      ),
          (r) => emit(
        TermsOfUseLoadedState(r),
      ),
    );
  }

  Future<void> requestAccountDeletionEvent(DataMap data) async {
    emit(RequestDeleteLoadingState());

    final result = await _requestAccountDeletion(data);

    result.fold(
          (l) => emit(
        RequestDeleteErrorState(l.errorMessage),
      ),
          (r) => emit(
        RequestDeleteLoadedState(),
      ),
    );
  }
}
