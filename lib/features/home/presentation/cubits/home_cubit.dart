
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/features/home/domain/entity/home_entity.dart';
import 'package:foursquare_ebbok_app/features/home/domain/usecases/get_dashboard_data.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required GetDashboardData getDashboardData,
  })  : _getDashboardData = getDashboardData,
        super(HomeInitial());

  final GetDashboardData _getDashboardData;

  Future<void> getDashboardDataEvent() async {

    emit(HomeDataLoading());

    final result = await _getDashboardData();

    result.fold(
      (l) => emit(
        HomeDataError(
          l.errorMessage,
        ),
      ),
      (r) => emit(
        HomeDataLoaded(r, true),
      ),
    );
  }
}
