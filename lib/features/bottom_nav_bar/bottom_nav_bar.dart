import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';
import 'package:foursquare_ebbok_app/features/authors/presentation/screens/authors_screen.dart';
import 'package:foursquare_ebbok_app/features/categories/presentation/screens/categories_screen.dart';
import 'package:foursquare_ebbok_app/features/home/presentation/screens/home_screen.dart';
import 'package:foursquare_ebbok_app/features/latest/presentation/cubits/latest_cubit.dart';
import 'package:foursquare_ebbok_app/features/latest/presentation/screens/latest_screen.dart';
import 'package:foursquare_ebbok_app/features/settings/presentation/screens/settings_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

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
    SettingsScreen(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          _currentIndex == 4 ? AppColors.redColor : Color(0xFFF5F5F5),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: screens[_currentIndex],
      ),
      bottomNavigationBar: Material(
        elevation: 10.0,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
                    }),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 10,
                      ),
                      decoration: _currentIndex == icons.indexOf(icon)
                          ? BoxDecoration(
                              // border: Border.all(),
                              borderRadius: BorderRadius.circular(6),
                              color: AppColors.purpleColor,
                            )
                          : null,
                      child: SvgPicture.asset(
                        'assets/icons/$icon.svg',
                        width: 30,
                        height: 30,
                        colorFilter: _currentIndex != icons.indexOf(icon)
                            ? null
                            : ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  label: '',
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
