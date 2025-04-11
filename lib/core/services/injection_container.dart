import 'package:foursquare_ebbok_app/features/book_details/data/datasource/book_details_remote_datasource.dart';
import 'package:foursquare_ebbok_app/features/book_details/data/repository/book_details_repository_impl.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/repository/book_details_repository.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/usecases/get_book_details.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/cubits/book_details_cubit.dart';
import 'package:foursquare_ebbok_app/features/home/data/datasource/home_remote_datasource.dart';
import 'package:foursquare_ebbok_app/features/home/data/repository/home_repository_impl.dart';
import 'package:foursquare_ebbok_app/features/home/domain/repository/home_repository.dart';
import 'package:foursquare_ebbok_app/features/home/domain/usecases/get_dashboard_data.dart';
import 'package:foursquare_ebbok_app/features/home/presentation/cubits/home_cubit.dart';
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
  await _homeInit();
  await _bookDetailsInit();
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

Future<void> _homeInit() async {
  sl
    ..registerFactory(
      () => HomeCubit(
        getDashboardData: sl(),
      ),
    )
    ..registerLazySingleton(() => GetDashboardData(sl()))
    ..registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()))
    ..registerLazySingleton<HomeRemoteDatasource>(
      () => HomeRemoteDatasourceImpl(sl()),
    );
}

Future<void> _bookDetailsInit() async {
  sl
    ..registerFactory(
      () => BookDetailsCubit(
        getBookDetails: sl(),
      ),
    )
    ..registerLazySingleton(() => GetBookDetails(sl()))
    ..registerLazySingleton<BookDetailsRepository>(
        () => BookDetailsRepositoryImpl(sl()))
    ..registerLazySingleton<BookDetailsRemoteDatasource>(
      () => BookDetailsRemoteDatasourceImpl(sl()),
    );
}
