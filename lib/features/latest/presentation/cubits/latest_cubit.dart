import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/features/latest/domain/usecases/get_latest_books.dart';
import 'package:foursquare_ebbok_app/features/latest/presentation/models/latest_model.dart';

part 'latest_state.dart';

class LatestCubit extends Cubit<LatestState> {
  LatestCubit({
    required GetLatestBooks getLatestBooks,
  })  : _getLatestBooks = getLatestBooks,
        super(LatestInitial());

  final GetLatestBooks _getLatestBooks;

  Future<void> latestScreenEvent(LatestModel model) async {
    emit(LatestScreenState(model));
  }

  Future<void> getLatestBooksEvent() async {
    final model = state.model;

    emit(
      LatestScreenState(
        model.copyWith(
          loading: true,
          error: '',
        ),
      ),
    );

    final result = await _getLatestBooks();

    result.fold(
      (l) => emit(
        LatestScreenState(
          model.copyWith(
            loading: false,
            error: l.errorMessage,
          ),
        ),
      ),
      (r) => emit(
        LatestScreenState(
          model.copyWith(
            loading: false,
            error: '',
            loaded: true,
            latestBooks: r,
          ),
        ),
      ),
    );
  }
}
