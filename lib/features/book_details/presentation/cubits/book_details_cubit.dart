import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/entity/book_details_entity.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/usecases/get_book_details.dart';

part 'book_details_state.dart';

class BookDetailsCubit extends Cubit<BookDetailsState> {
  BookDetailsCubit({
    required GetBookDetails getBookDetails,
  })  : _getBookDetails = getBookDetails,
        super(BookDetailsInitial());

  final GetBookDetails _getBookDetails;

  Future<void> getBookDetailsEvent(String id) async {
    emit(BookDetailsLoadingState());

    final result = await _getBookDetails(id);

    result.fold(
      (l) => emit(
        BookDetailsErrorState(
          l.errorMessage,
        ),
      ),
      (r) => emit(BookDetailsLoadedState(r)),
    );
  }
}
