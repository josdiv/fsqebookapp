import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foursquare_ebbok_app/core/ui/download_page/download_page.dart';
import 'package:foursquare_ebbok_app/core/utils/offline_guard/offline_guard.dart';
import 'package:foursquare_ebbok_app/features/authors/presentation/cubits/authors_cubit.dart';
import 'package:foursquare_ebbok_app/features/book_details/presentation/cubits/book_details_cubit.dart';
import 'package:foursquare_ebbok_app/features/buy_book/presentation/cubits/buy_book_cubit.dart';
import 'package:foursquare_ebbok_app/features/categories/presentation/cubits/categories_cubit.dart';
import 'package:foursquare_ebbok_app/features/home/presentation/cubits/home_cubit.dart';
import 'package:foursquare_ebbok_app/features/latest/presentation/cubits/latest_cubit.dart';
import 'package:foursquare_ebbok_app/features/login/presentation/cubits/login_cubit.dart';
import 'package:foursquare_ebbok_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:foursquare_ebbok_app/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:foursquare_ebbok_app/features/ratings/presentation/cubits/ratings_cubit.dart';
import 'package:foursquare_ebbok_app/features/settings/presentation/cubits/settings_cubit.dart';
import 'package:foursquare_ebbok_app/features/sign_up/presentation/cubits/sign_up_cubit.dart';
import 'package:foursquare_ebbok_app/features/status/presentation/cubits/status_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:shared_preferences/shared_preferences.dart';
import 'core/services/injection_container.dart';
import 'features/book_details/domain/repository/download_repository.dart';
import 'features/bottom_nav_bar/bottom_nav_bar.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await init();
  await dotenv.load(fileName: ".env");
  await DownloadsRepository.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // final prefs = await SharedPreferences.getInstance();
  // prefs.clear();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  Widget? _initialScreen;

  @override
  void initState() {
    super.initState();
    initialization();
  }

  Future<void> initialization() async {
    print('Pausing...');
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    final hasOnboarded = prefs.getBool('hasOnboarded') ?? false;

    setState(() {
      _initialScreen =
          hasOnboarded ? const BottomNavBar() : const OnboardingScreen();
    });

    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LatestCubit>(create: (context) => sl<LatestCubit>()),
        BlocProvider<HomeCubit>(create: (context) => sl<HomeCubit>()),
        BlocProvider<SettingsCubit>(create: (context) => sl<SettingsCubit>()),
        BlocProvider<BookDetailsCubit>(
            create: (context) => sl<BookDetailsCubit>()),
        BlocProvider<CategoriesCubit>(
            create: (context) => sl<CategoriesCubit>()),
        BlocProvider<AuthorsCubit>(create: (context) => sl<AuthorsCubit>()),
        BlocProvider<SignUpCubit>(create: (context) => sl<SignUpCubit>()),
        BlocProvider<RatingsCubit>(create: (context) => sl<RatingsCubit>()),
        BlocProvider<LoginCubit>(create: (context) => sl<LoginCubit>()),
        BlocProvider<ProfileCubit>(create: (context) => sl<ProfileCubit>()),
        BlocProvider<StatusCubit>(create: (context) => sl<StatusCubit>()),
        BlocProvider<BuyBookCubit>(create: (context) => sl<BuyBookCubit>()),
      ],
      child: MaterialApp(
        title: 'FourSquare Ebbok App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: OfflineGuard(
          homePage: _initialScreen ??
              const Scaffold(
                // show loader while deciding
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ), downloadPage: DownloadPage(),
        ),
      ),
    );
  }
}

//Your app-specific password is:
// wlbf-ckfy-qaos-ksqz
