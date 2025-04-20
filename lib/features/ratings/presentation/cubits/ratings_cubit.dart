import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/features/ratings/domain/usecases/get_book_ratings.dart';
import 'package:foursquare_ebbok_app/features/ratings/presentation/model/rating_model.dart';

part 'ratings_state.dart';

class RatingsCubit extends Cubit<RatingsState> {
  RatingsCubit({
    required GetBookRatings getBookRatings,
  })  : _getBookRatings = getBookRatings,
        super(RatingsInitial());

  final GetBookRatings _getBookRatings;

  Future<void> ratingsScreenEvent(RatingModel model) async {
    emit(RatingsScreenState(model));
  }

  Future<void> getBookRatingsEvent(String id) async {
    final model = state.model;
    final screenModel = model.screenModel;

    emit(
      RatingsScreenState(
        model.copyWith(
          screenModel: screenModel.copyWith(
            loading: true,
            loaded: false,
            error: '',
          ),
        ),
      ),
    );

    final result = await _getBookRatings(id);

    result.fold(
      (l) => emit(
        RatingsScreenState(
          model.copyWith(
            screenModel: screenModel.copyWith(
              loading: false,
              loaded: false,
              error: l.errorMessage,
            ),
          ),
        ),
      ),
      (r) => emit(
        RatingsScreenState(
          model.copyWith(
            screenModel: screenModel.copyWith(
              loading: false,
              loaded: true,
              error: '',
              ratings: r,
            ),
          ),
        ),
      ),
    );
  }
}
