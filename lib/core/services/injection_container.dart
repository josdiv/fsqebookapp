import 'package:foursquare_ebbok_app/features/latest/data/datasource/latest_remote_datasource.dart';
import 'package:foursquare_ebbok_app/features/latest/data/repository/latest_repository_impl.dart';
import 'package:foursquare_ebbok_app/features/latest/domain/repository/latest_repository.dart';
import 'package:foursquare_ebbok_app/features/latest/domain/usecases/get_latest_books.dart';
import 'package:foursquare_ebbok_app/features/latest/presentation/cubits/latest_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl
      // External Dependencies
      .registerLazySingleton(() => http.Client());

  await _latestBookInit();
}

Future<void> _latestBookInit() async {
  sl
    ..registerFactory(
      () => LatestCubit(
        getLatestBooks: sl(),
      ),
    )
    ..registerLazySingleton(() => GetLatestBooks(sl()))
    ..registerLazySingleton<LatestRepository>(() => LatestRepositoryImpl(sl()))
    ..registerLazySingleton<LatestRemoteDatasource>(
      () => LatestRemoteDatasourceImpl(sl()),
    );
}
