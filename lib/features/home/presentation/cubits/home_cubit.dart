import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/core/utils/typedefs/typedefs.dart';
import 'package:foursquare_ebbok_app/features/home/domain/usecases/delete_account.dart';
import 'package:foursquare_ebbok_app/features/home/domain/usecases/get_dashboard_data.dart';
import 'package:foursquare_ebbok_app/features/home/domain/usecases/get_searched_books.dart';
import 'package:foursquare_ebbok_app/features/home/presentation/models/home_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required GetDashboardData getDashboardData,
    required GetSearchedBooks getSearchedBooks,
    required DeleteAccount deleteAccount,
  })  : _getSearchedBooks = getSearchedBooks,
        _getDashboardData = getDashboardData,
        _deleteAccount = deleteAccount,
        super(HomeInitial());

  final GetDashboardData _getDashboardData;
  final GetSearchedBooks _getSearchedBooks;
  final DeleteAccount _deleteAccount;

  Future<void> homeScreenEvent(HomeModel model) async {
    emit(HomeScreenState(model));
  }

  Future<void> getDashboardDataEvent() async {
    final model = state.model;
    final model1 = model.model1;

    emit(
      HomeScreenState(
        model.copyWith(
          model1: model1.copyWith(
            loading: true,
            error: '',
          ),
        ),
      ),
    );

    final result = await _getDashboardData();

    result.fold(
      (l) => emit(
        HomeScreenState(
          model.copyWith(
            model1: model1.copyWith(
              loading: false,
              error: l.errorMessage,
            ),
          ),
        ),
      ),
      (r) => emit(
        HomeScreenState(
          model.copyWith(
            model1: model1.copyWith(
              loading: false,
              error: '',
              loaded: true,
              homeData: r,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getSearchedBookEvent(String params) async {
    final model = state.model;
    final model2 = model.model2;

    emit(
      HomeScreenState(
        model.copyWith(
          model2: model2.copyWith(
            loading: true,
            error: '',
          ),
        ),
      ),
    );

    final result = await _getSearchedBooks(params);

    result.fold(
      (l) => emit(
        HomeScreenState(
          model.copyWith(
            model2: model2.copyWith(
              loading: false,
              error: l.errorMessage,
            ),
          ),
        ),
      ),
      (r) => emit(
        HomeScreenState(
          model.copyWith(
            model2: model2.copyWith(
              loading: false,
              error: '',
              loaded: true,
              searchedBooks: r,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> deleteAccountEvent(DataMap data) async {
    final model = state.model;
    final model3 = model.model3;

    emit(
      HomeScreenState(
        model.copyWith(
          model3: model3.copyWith(
            loading: true,
            error: '',
          ),
        ),
      ),
    );

    final result = await _deleteAccount(data);

    result.fold(
      (l) => emit(
        HomeScreenState(
          model.copyWith(
            model3: model3.copyWith(
              loading: false,
              error: l.errorMessage,
            ),
          ),
        ),
      ),
      (r) => emit(
        HomeScreenState(
          model.copyWith(
            model3: model3.copyWith(
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
