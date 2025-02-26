import 'package:flutter/material.dart';
import 'package:foursquare_ebbok_app/core/theme/app_text_styles.dart';

class AppTheme {
  static ThemeData getTheme() {
    return ThemeData(
      brightness: Brightness.light,
      textTheme: TextTheme(
        bodySmall: AppTextStyles.bodySmall,
        bodyMedium: AppTextStyles.bodyMedium,
        bodyLarge: AppTextStyles.bodyLarge,
        headlineSmall: AppTextStyles.headlineSmall,
        headlineMedium: AppTextStyles.headlineMedium,
        headlineLarge: AppTextStyles.headlineLarge,
      )
    );
  }
}