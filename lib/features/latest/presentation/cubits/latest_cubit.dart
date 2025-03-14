
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/features/latest/domain/entity/latest_entity.dart';
import 'package:foursquare_ebbok_app/features/latest/domain/usecases/get_latest_books.dart';

part 'latest_state.dart';

class LatestCubit extends Cubit<LatestState> {
  LatestCubit({
    required GetLatestBooks getLatestBooks,
  })  : _getLatestBooks = getLatestBooks,
        super(LatestInitial());

  final GetLatestBooks _getLatestBooks;

  Future<void> getLatestBooksEvent() async {
    emit(LatestBooksLoading());

    final result = await _getLatestBooks();

    result.fold(
      (l) => emit(
        LatestBooksError(
          l.errorMessage,
        ),
      ),
      (r) => emit(
        LatestBooksLoaded(
          true,
          r,
        ),
      ),
    );
  }
}
