import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:foursquare_ebbok_app/core/misc/spacer.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';
import 'package:foursquare_ebbok_app/core/ui/widgets/default_button.dart';
import 'package:foursquare_ebbok_app/features/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:foursquare_ebbok_app/features/onboarding/presentation/model/onboarding_model.dart';
import 'package:foursquare_ebbok_app/features/onboarding/presentation/screens/widgets/onboarding_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int index = 0;
  final PageController _pageController = PageController();

  void _goToNextPage() {
    if (index < 2) {
      // Adjust based on your total pages
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> setOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasOnboarded', true);
  }

  @override
  void initState() {
    super.initState();
    setOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    final models = [
      OnboardingModel(
        image: 'onboarding_1',
        title: 'Books for every Occasion',
        subtitle:
            'Find a variety of books both Free and Paid grouped in Categories and from several Author...',
      ),
      OnboardingModel(
        image: 'onboarding_2',
        title: 'Interactive Books',
        subtitle:
            'Read, Bookmark, Highlight, Return to Page left off and any more Features...',
      ),
      OnboardingModel(
        image: 'onboarding_3',
        title: 'Easy Explore',
        subtitle:
            'Night Mode, Favorite Books, Share, Rate, and Review Books...',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const VSpace(50),
            if (index != 0)
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavBar(),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.orangeColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            VSpace(30),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (x) {
                  setState(() {
                    index = x;
                  });
                },
                children: models
                    .map(
                      (model) => OnboardingWidget(
                        image: model.image,
                        title: model.title,
                        subtitle: model.subtitle,
                        color: models.indexOf(model) == 0
                            ? AppColors.orangeColor
                            : models.indexOf(model) == 1
                                ? AppColors.redColor
                                : AppColors.orangeColor,
                      ),
                    )
                    .toList(),
              ),
            ),
            index == 2
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: DefaultButton(
                      text: 'GET STARTED',
                      backgroundColor: AppColors.orangeColor,
                      opacity: true,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BottomNavBar(),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DotsIndicator(
                          dotsCount: 3,
                          position: index.toDouble(),
                          decorator: DotsDecorator(
                            spacing:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            color: Color(0xFF504F6D).withValues(alpha: .4),
                            activeColor: AppColors.orangeColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            size: const Size(12.0, 12.0),
                            // Oval shape
                            activeSize: const Size(26.0, 12.0),
                          ),
                        ),
                        GestureDetector(
                          onTap: _goToNextPage,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40.0,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.orangeColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "Next",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
            VSpace(50)
          ],
        ),
      ),
    );
  }
}
