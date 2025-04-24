import 'package:foursquare_ebbok_app/features/authors/data/datasource/authors_remote_datasource.dart';
import 'package:foursquare_ebbok_app/features/authors/data/repository/authors_repository_impl.dart';
import 'package:foursquare_ebbok_app/features/authors/domain/repository/authors_repository.dart';
import 'package:foursquare_ebbok_app/features/authors/domain/usecases/get_authors.dart';
import 'package:foursquare_ebbok_app/features/authors/domain/usecases/get_single_author.dart';
import 'package:foursquare_ebbok_app/features/authors/presentation/cubits/authors_cubit.dart';
import 'package:foursquare_ebbok_app/features/book_details/data/datasource/book_details_remote_datasource.dart';
import 'package:foursquare_ebbok_app/features/book_details/data/repository/book_details_repository_impl.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/repository/book_details_repository.dart';
import 'package:foursquare_ebbok_app/features/book_details/domain/usecases/get_book_details.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/cubits/book_details_cubit.dart';
import 'package:foursquare_ebbok_app/features/categories/data/datasource/categories_remote_datasource.dart';
import 'package:foursquare_ebbok_app/features/categories/data/repository/categories_repository_impl.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/repository/categories_repository.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/usecases/get_categories.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/usecases/get_sub_categories.dart';
import 'package:foursquare_ebbok_app/features/categories/domain/usecases/get_sub_categories_details.dart';
import 'package:foursquare_ebbok_app/features/categories/presentation/cubits/categories_cubit.dart';
import 'package:foursquare_ebbok_app/features/home/data/datasource/home_remote_datasource.dart';
import 'package:foursquare_ebbok_app/features/home/data/repository/home_repository_impl.dart';
import 'package:foursquare_ebbok_app/features/home/domain/repository/home_repository.dart';
import 'package:foursquare_ebbok_app/features/home/domain/usecases/delete_account.dart';
import 'package:foursquare_ebbok_app/features/home/domain/usecases/get_dashboard_data.dart';
import 'package:foursquare_ebbok_app/features/home/domain/usecases/get_searched_books.dart';
import 'package:foursquare_ebbok_app/features/home/presentation/cubits/home_cubit.dart';
import 'package:foursquare_ebbok_app/features/latest/data/datasource/latest_remote_datasource.dart';
import 'package:foursquare_ebbok_app/features/latest/data/repository/latest_repository_impl.dart';
import 'package:foursquare_ebbok_app/features/latest/domain/repository/latest_repository.dart';
import 'package:foursquare_ebbok_app/features/latest/domain/usecases/get_latest_books.dart';
import 'package:foursquare_ebbok_app/features/latest/presentation/cubits/latest_cubit.dart';
import 'package:foursquare_ebbok_app/features/login/data/datasource/login_remote_datasource.dart';
import 'package:foursquare_ebbok_app/features/login/data/repository/login_repository_impl.dart';
import 'package:foursquare_ebbok_app/features/login/domain/repository/login_repository.dart';
import 'package:foursquare_ebbok_app/features/login/domain/usecases/sign_in_with_google.dart';
import 'package:foursquare_ebbok_app/features/login/domain/usecases/sign_in_with_password.dart';
import 'package:foursquare_ebbok_app/features/login/presentation/cubits/login_cubit.dart';
import 'package:foursquare_ebbok_app/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:foursquare_ebbok_app/features/profile/data/repository/profile_repository_impl.dart';
import 'package:foursquare_ebbok_app/features/profile/domain/repository/profile_repository.dart';
import 'package:foursquare_ebbok_app/features/profile/domain/usecases/edit_user_profile.dart';
import 'package:foursquare_ebbok_app/features/profile/domain/usecases/get_user_profile.dart';
import 'package:foursquare_ebbok_app/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:foursquare_ebbok_app/features/ratings/data/datasource/ratings_remote_datasource.dart';
import 'package:foursquare_ebbok_app/features/ratings/data/repository/ratings_repository_impl.dart';
import 'package:foursquare_ebbok_app/features/ratings/domain/repository/ratings_repository.dart';
import 'package:foursquare_ebbok_app/features/ratings/domain/usecases/get_book_ratings.dart';
import 'package:foursquare_ebbok_app/features/ratings/presentation/cubits/ratings_cubit.dart';
import 'package:foursquare_ebbok_app/features/settings/data/datasource/settings_remote_datasource.dart';
import 'package:foursquare_ebbok_app/features/settings/data/repository/settings_repository_impl.dart';
import 'package:foursquare_ebbok_app/features/settings/domain/repository/settings_repository.dart';
import 'package:foursquare_ebbok_app/features/settings/domain/usecases/get_about_us.dart';
import 'package:foursquare_ebbok_app/features/settings/domain/usecases/get_terms_of_use.dart';
import 'package:foursquare_ebbok_app/features/settings/domain/usecases/request_account_deletion.dart';
import 'package:foursquare_ebbok_app/features/settings/presentation/cubits/settings_cubit.dart';
import 'package:foursquare_ebbok_app/features/sign_up/data/datasource/sign_up_remote_datasource.dart';
import 'package:foursquare_ebbok_app/features/sign_up/data/repository/sign_up_repository_impl.dart';
import 'package:foursquare_ebbok_app/features/sign_up/domain/repository/sign_up_repository.dart';
import 'package:foursquare_ebbok_app/features/sign_up/domain/usecases/user_sign_up.dart';
import 'package:foursquare_ebbok_app/features/sign_up/presentation/cubits/sign_up_cubit.dart';
import 'package:foursquare_ebbok_app/features/status/data/datasource/status_local_datasource.dart';
import 'package:foursquare_ebbok_app/features/status/data/repository/status_repository_impl.dart';
import 'package:foursquare_ebbok_app/features/status/domain/repository/status_repository.dart';
import 'package:foursquare_ebbok_app/features/status/domain/usecases/get_user_login_status.dart';
import 'package:foursquare_ebbok_app/features/status/domain/usecases/set_user_login_status.dart';
import 'package:foursquare_ebbok_app/features/status/presentation/cubits/status_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  sl
    ..registerLazySingleton(() => http.Client())
    ..registerLazySingleton(() => sharedPrefs);

  await _latestBookInit();
  await _homeInit();
  await _bookDetailsInit();
  await _settingsInit();
  await _categoriesInit();
  await _authorsInit();
  await _ratingsInit();
  await _signUpInit();
  await _loginInit();
  await _profileInit();
  await _statusInit();
}

Future<void> _profileInit() async {
  sl
    ..registerFactory(
      () => ProfileCubit(
        getUserProfile: sl(),
        editUserProfile: sl(),
      ),
    )
    ..registerLazySingleton(() => GetUserProfile(sl()))
    ..registerLazySingleton(() => EditUserProfile(sl()))
    ..registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(sl()))
    ..registerLazySingleton<ProfileRemoteDatasource>(
      () => ProfileRemoteDatasourceImpl(sl()),
    );
}

Future<void> _statusInit() async {
  sl
    ..registerFactory(
      () => StatusCubit(
        getUserLoginStatus: sl(),
        setUserLoginStatus: sl(),
      ),
    )
    ..registerLazySingleton(() => GetUserLoginStatus(sl()))
    ..registerLazySingleton(() => SetUserLoginStatus(sl()))
    ..registerLazySingleton<StatusRepository>(() => StatusRepositoryImpl(sl()))
    ..registerLazySingleton<StatusLocalDatasource>(
      () => StatusLocalDatasourceImpl(sl()),
    );
}

Future<void> _loginInit() async {
  sl
    ..registerFactory(
      () => LoginCubit(
        signInWithPassword: sl(),
        signInWithGoogle: sl(),
      ),
    )
    ..registerLazySingleton(() => SignInWithGoogle(sl()))
    ..registerLazySingleton(() => SignInWithPassword(sl()))
    ..registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(sl()))
    ..registerLazySingleton<LoginRemoteDatasource>(
      () => LoginRemoteDatasourceImpl(sl()),
    );
}

Future<void> _ratingsInit() async {
  sl
    ..registerFactory(
      () => RatingsCubit(
        getBookRatings: sl(),
      ),
    )
    ..registerLazySingleton(() => GetBookRatings(sl()))
    ..registerLazySingleton<RatingsRepository>(
        () => RatingsRepositoryImpl(sl()))
    ..registerLazySingleton<RatingsRemoteDatasource>(
      () => RatingsRemoteDatasourceImpl(sl()),
    );
}

Future<void> _signUpInit() async {
  sl
    ..registerFactory(
      () => SignUpCubit(
        userSignUp: sl(),
      ),
    )
    ..registerLazySingleton(() => UserSignUp(sl()))
    ..registerLazySingleton<SignUpRepository>(() => SignUpRepositoryImpl(sl()))
    ..registerLazySingleton<SignUpRemoteDatasource>(
      () => SignUpRemoteDatasourceImpl(sl()),
    );
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
        getSearchedBooks: sl(),
        deleteAccount: sl(),
      ),
    )
    ..registerLazySingleton(() => GetDashboardData(sl()))
    ..registerLazySingleton(() => GetSearchedBooks(sl()))
    ..registerLazySingleton(() => DeleteAccount(sl()))
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

Future<void> _settingsInit() async {
  sl
    ..registerFactory(
      () => SettingsCubit(
        getAboutUs: sl(),
        getTermsOfUse: sl(),
        requestAccountDeletion: sl(),
      ),
    )
    ..registerLazySingleton(() => GetAboutUs(sl()))
    ..registerLazySingleton(() => GetTermsOfUse(sl()))
    ..registerLazySingleton(() => RequestAccountDeletion(sl()))
    ..registerLazySingleton<SettingsRepository>(
        () => SettingsRepositoryImpl(sl()))
    ..registerLazySingleton<SettingsRemoteDatasource>(
      () => SettingsRemoteDatasourceImpl(sl()),
    );
}

Future<void> _categoriesInit() async {
  sl
    ..registerFactory(
      () => CategoriesCubit(
        getCategories: sl(),
        getSubCategories: sl(),
        getSubCategoriesDetails: sl(),
      ),
    )
    ..registerLazySingleton(() => GetCategories(sl()))
    ..registerLazySingleton(() => GetSubCategories(sl()))
    ..registerLazySingleton(() => GetSubCategoriesDetails(sl()))
    ..registerLazySingleton<CategoriesRepository>(
        () => CategoriesRepositoryImpl(sl()))
    ..registerLazySingleton<CategoriesRemoteDatasource>(
      () => CategoriesRemoteDatasourceImpl(sl()),
    );
}

Future<void> _authorsInit() async {
  sl
    ..registerFactory(
      () => AuthorsCubit(
        getSingleAuthor: sl(),
        getAuthors: sl(),
      ),
    )
    ..registerLazySingleton(() => GetSingleAuthor(sl()))
    ..registerLazySingleton(() => GetAuthors(sl()))
    ..registerLazySingleton<AuthorsRepository>(
        () => AuthorsRepositoryImpl(sl()))
    ..registerLazySingleton<AuthorsRemoteDatasource>(
      () => AuthorsRemoteDatasourceImpl(sl()),
    );
}
