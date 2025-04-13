import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/features/home/domain/usecases/get_dashboard_data.dart';
import 'package:foursquare_ebbok_app/features/home/presentation/models/home_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required GetDashboardData getDashboardData,
  })  : _getDashboardData = getDashboardData,
        super(HomeInitial());

  final GetDashboardData _getDashboardData;

  Future<void> homeScreenEvent(HomeModel model) async {
    emit(HomeScreenState(model));
  }

  Future<void> getDashboardDataEvent() async {
    final model = state.model;

    emit(
      HomeScreenState(
        model.copyWith(
          loading: true,
          error: '',
        ),
      ),
    );

    final result = await _getDashboardData();

    result.fold(
      (l) => emit(
        HomeScreenState(
          model.copyWith(
            loading: false,
            error: l.errorMessage,
          ),
        ),
      ),
      (r) => emit(
        HomeScreenState(
          model.copyWith(
            loading: false,
            error: '',
            loaded: true,
            homeData: r,
          ),
        ),
      ),
    );
  }
}
