import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/usecases/download_book.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/usecases/get_book_details.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/usecases/read_book.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/usecases/report_book.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/usecases/toggle_favourite.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/usecases/write_review.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/models/book_details_model.dart';

part 'book_details_state.dart';

class BookDetailsCubit extends Cubit<BookDetailsState> {
  BookDetailsCubit({
    required GetBookDetails getBookDetails,
    required ReportBook reportBook,
    required ToggleFavourite toggleFavourite,
    required ReadBook readBook,
    required DownloadBook downloadBook,
    required WriteReview writeReview,
  })  : _getBookDetails = getBookDetails,
        _reportBook = reportBook,
        _toggleFavourite = toggleFavourite,
        _readBook = readBook,
        _downloadBook = downloadBook,
        _writeReview = writeReview,
        super(BookDetailsInitial());

  final GetBookDetails _getBookDetails;
  final ReportBook _reportBook;
  final ToggleFavourite _toggleFavourite;
  final ReadBook _readBook;
  final DownloadBook _downloadBook;
  final WriteReview _writeReview;

  Future<void> bookDetailsScreenEvent(BookDetailsModel model) async {
    emit(BookDetailsScreenState(model));
  }

  Future<void> getBookDetailsEvent(DataMap data) async {
    print(data);
    final model = state.model;
    final getBookDetailsModel = model.getBookDetailsModel;

    emit(
      BookDetailsScreenState(
        model.copyWith(
          getBookDetailsModel: getBookDetailsModel.copyWith(
            loading: true,
            error: '',
            loaded: false,
          ),
        ),
      ),
    );

    final result = await _getBookDetails(data);

    result.fold(
      (l) => emit(
        BookDetailsScreenState(
          model.copyWith(
            getBookDetailsModel: getBookDetailsModel.copyWith(
              loading: false,
              error: l.errorMessage,
              loaded: false,
            ),
          ),
        ),
      ),
      (r) => emit(
        BookDetailsScreenState(
          model.copyWith(
            purchasedStatus: r.purchasedStatus,
            favStatus: r.favStatus,
            getBookDetailsModel: getBookDetailsModel.copyWith(
              loading: false,
              error: '',
              loaded: true,
              entity: r,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> reportBookEvent(DataMap data) async {
    final model = state.model;
    final reportBookModel = model.reportBookModel;

    emit(
      BookDetailsScreenState(
        model.copyWith(
          reportBookModel: reportBookModel.copyWith(
            loading: true,
            error: '',
            loaded: false,
          ),
        ),
      ),
    );

    final result = await _reportBook(data);

    result.fold(
      (l) => emit(
        BookDetailsScreenState(
          model.copyWith(
            reportBookModel: reportBookModel.copyWith(
              loading: false,
              error: l.errorMessage,
              loaded: false,
            ),
          ),
        ),
      ),
      (r) => emit(
        BookDetailsScreenState(
          model.copyWith(
            reportBookModel: reportBookModel.copyWith(
              loading: false,
              error: '',
              loaded: true,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> toggleFavouriteEvent(DataMap data) async {
    final model = state.model;
    final toggleFavouriteModel = model.toggleFavouriteModel;

    emit(
      BookDetailsScreenState(
        model.copyWith(
          toggleFavouriteModel: toggleFavouriteModel.copyWith(
            loading: true,
            error: '',
            loaded: false,
          ),
        ),
      ),
    );

    final result = await _toggleFavourite(data);

    result.fold(
      (l) => emit(
        BookDetailsScreenState(
          model.copyWith(
            toggleFavouriteModel: toggleFavouriteModel.copyWith(
              loading: false,
              error: l.errorMessage,
              loaded: false,
            ),
          ),
        ),
      ),
      (r) => emit(
        BookDetailsScreenState(
          model.copyWith(
            toggleFavouriteModel: toggleFavouriteModel.copyWith(
              loading: false,
              error: '',
              loaded: true,
              message: r,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> readBookEvent(DataMap data) async {
    final model = state.model;
    final readBookModel = model.readBookModel;

    emit(
      BookDetailsScreenState(
        model.copyWith(
          readBookModel: readBookModel.copyWith(
            loading: true,
            error: '',
            loaded: false,
          ),
        ),
      ),
    );

    final result = await _readBook(data);

    result.fold(
      (l) => emit(
        BookDetailsScreenState(
          model.copyWith(
            readBookModel: readBookModel.copyWith(
              loading: false,
              error: l.errorMessage,
              loaded: false,
            ),
          ),
        ),
      ),
      (r) => emit(
        BookDetailsScreenState(
          model.copyWith(
            readBookModel: readBookModel.copyWith(
              loading: false,
              error: '',
              loaded: true,
              entity: r,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> downloadBookEvent(DataMap data) async {
    final model = state.model;
    final downloadBookModel = model.downloadBookModel;

    emit(
      BookDetailsScreenState(
        model.copyWith(
          downloadBookModel: downloadBookModel.copyWith(
            loading: true,
            error: '',
            loaded: false,
          ),
        ),
      ),
    );

    final result = await _downloadBook(data);

    result.fold(
      (l) => emit(
        BookDetailsScreenState(
          model.copyWith(
            downloadBookModel: downloadBookModel.copyWith(
              loading: false,
              error: l.errorMessage,
              loaded: false,
            ),
          ),
        ),
      ),
      (r) => emit(
        BookDetailsScreenState(
          model.copyWith(
            downloadBookModel: downloadBookModel.copyWith(
              loading: false,
              error: '',
              loaded: true,
              entity: r,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> writeReviewEvent(DataMap data) async {
    final model = state.model;
    final writeReviewModel = model.writeReviewModel;

    emit(
      BookDetailsScreenState(
        model.copyWith(
          writeReviewModel: writeReviewModel.copyWith(
            loading: true,
            error: '',
            loaded: false,
          ),
        ),
      ),
    );

    final result = await _writeReview(data);

    result.fold(
      (l) => emit(
        BookDetailsScreenState(
          model.copyWith(
            writeReviewModel: writeReviewModel.copyWith(
              loading: false,
              error: l.errorMessage,
              loaded: false,
            ),
          ),
        ),
      ),
      (r) => emit(
        BookDetailsScreenState(
          model.copyWith(
            writeReviewModel: writeReviewModel.copyWith(
              loading: false,
              error: '',
              loaded: true,
            ),
          ),
        ),
      ),
    );
  }
}
