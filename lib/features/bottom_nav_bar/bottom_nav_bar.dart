import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_close_app/flutter_close_app.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';
import 'package:foursquare_ebbok_app/features/authors/presentation/cubits/authors_cubit.dart';
import 'package:foursquare_ebbok_app/features/authors/presentation/screens/authors_screen/authors_screen.dart';
import 'package:foursquare_ebbok_app/features/categories/presentation/cubits/categories_cubit.dart';
import 'package:foursquare_ebbok_app/features/categories/presentation/screens/categories_screen/categories_screen.dart';
import 'package:foursquare_ebbok_app/features/home/presentation/cubits/home_cubit.dart';
import 'package:foursquare_ebbok_app/features/home/presentation/screens/home_screen/home_screen.dart';
import 'package:foursquare_ebbok_app/features/latest/presentation/cubits/latest_cubit.dart';
import 'package:foursquare_ebbok_app/features/latest/presentation/screens/latest_screen.dart';
import 'package:foursquare_ebbok_app/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:foursquare_ebbok_app/features/profile/presentation/screens/profile_screen/profile_screen.dart';
import 'package:foursquare_ebbok_app/features/status/presentation/cubits/status_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/helper/common_loader.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, this.currentIndex = 0});

  final int currentIndex;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final icons = ['home', 'latest', 'category', 'author', 'setting'];
  final screens = [
    HomeScreen(),
    LatestScreen(),
    CategoriesScreen(),
    AuthorsScreen(),
    ProfileScreen(),
  ];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getDashboardDataEvent();
    context.read<StatusCubit>().getUserLoginStatusEvent();
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        final model = state.model;
        final model1 = model.model1;
        final event = context.read<HomeCubit>();

        if (model1.hasError) {
          Loader.hide();
          showSnackBar(context, model1.error);
          event.homeScreenEvent(
            model.copyWith(
              model1: model1.copyWith(
                error: '',
              ),
            ),
          );
        }

        if (model1.loaded && Loader.isShown) {
          Loader.hide();
        }
      },
      builder: (context, state) {
        final model = state.model;
        final model1 = model.model1;

        if (model1.loadOnce) {
          commonLoader(context);
        }
        return BlocListener<StatusCubit, StatusState>(
          listener: (context, state) async {
            final model = state.model;
            print(model.isUserLoggedIn);
            final prefs = await SharedPreferences.getInstance();
            final email = prefs.getString('email');
            if (model.isUserLoggedIn) {
              print(email);
              context.read<ProfileCubit>().getUserProfileEvent(email!);
            }
          },
          child: BlocListener<LatestCubit, LatestState>(
            listener: (context, state) {
              final model = state.model;
              final event = context.read<LatestCubit>();

              if (model.loadOnce) {
                commonLoader(context);
              }

              if (model.hasError) {
                Loader.hide();
                showSnackBar(context, model.error);

                event.latestScreenEvent(
                  model.copyWith(
                    error: '',
                  ),
                );
              }

              if (model.loaded && Loader.isShown) {
                Loader.hide();
              }
            },
            child: BlocListener<CategoriesCubit, CategoriesState>(
              listener: (context, state) {
                final model = state.model;
                final model1 = model.model1;
                final event = context.read<CategoriesCubit>();

                if (model1.newLoading) {
                  commonLoader(context);
                }

                if (model1.hasError) {
                  Loader.hide();
                  showSnackBar(context, model1.error);
                  event.categoriesScreenEvent(
                    model.copyWith(
                      model1: model1.copyWith(
                        error: '',
                      ),
                    ),
                  );
                }

                if (model1.loaded && Loader.isShown) {
                  Loader.hide();
                  // event.categoriesScreenEvent(
                  //   model.copyWith(
                  //     model1: model1.copyWith(
                  //       loaded: false,
                  //     ),
                  //   ),
                  // );
                }
              },
              child: BlocListener<AuthorsCubit, AuthorsState>(
                listener: (context, state) {
                  final event = context.read<AuthorsCubit>();
                  final model = state.model;
                  final model1 = model.getAuthorsNetworkModel;

                  if (model1.newLoading) {
                    commonLoader(context);
                  }

                  if (model1.hasError) {
                    Loader.hide();
                    showSnackBar(context, model1.error);
                    event.authorScreenEvent(
                      model.copyWith(
                        getAuthorsNetworkModel: model1.copyWith(
                          error: '',
                        ),
                      ),
                    );
                  }

                  if (model1.loaded && Loader.isShown) {
                    Loader.hide();
                  }
                },
                child: FlutterCloseAppPage(
                  onCloseFailed: () {
                    // Condition does not match: the first press or the second press interval is more than 2 seconds, display a prompt message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Press again to exit 🎉"),
                      ),
                    );
                  },
                  child: Scaffold(
                    backgroundColor: _currentIndex == 4
                        ? AppColors.redColor
                        : Color(0xFFF5F5F5),
                    body: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: _currentIndex == 4 ? 0.0 : 20.0),
                      child: screens[_currentIndex],
                    ),
                    bottomNavigationBar: Material(
                      elevation: 10.0,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      child: BottomNavigationBar(
                        backgroundColor: Colors.white,
                        currentIndex: _currentIndex,
                        items: icons
                            .map(
                              (icon) => BottomNavigationBarItem(
                                backgroundColor: Colors.white,
                                icon: GestureDetector(
                                  onTap: () => setState(() {
                                    _currentIndex = icons.indexOf(icon);
                                    if (icons.indexOf(icon) == 0) {
                                      context
                                          .read<HomeCubit>()
                                          .getDashboardDataEvent();
                                    }
                                    if (icons.indexOf(icon) == 1) {
                                      context
                                          .read<LatestCubit>()
                                          .getLatestBooksEvent();
                                    }
                                    if (icons.indexOf(icon) == 2) {
                                      context
                                          .read<CategoriesCubit>()
                                          .getCategoriesEvent();
                                    }
                                    if (icons.indexOf(icon) == 3) {
                                      context
                                          .read<AuthorsCubit>()
                                          .getAuthorsEvent();
                                    }
                                  }),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 10,
                                    ),
                                    decoration:
                                        _currentIndex == icons.indexOf(icon)
                                            ? BoxDecoration(
                                                // border: Border.all(),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: AppColors.purpleColor,
                                              )
                                            : null,
                                    child: SvgPicture.asset(
                                      'assets/icons/$icon.svg',
                                      width: 30,
                                      height: 30,
                                      colorFilter: _currentIndex !=
                                              icons.indexOf(icon)
                                          ? null
                                          : ColorFilter.mode(
                                              Colors.white, BlendMode.srcIn),
                                    ),
                                  ),
                                ),
                                label: '',
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
