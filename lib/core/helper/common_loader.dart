import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:foursquare_ebbok_app/core/theme/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void commonLoader(BuildContext context) => Loader.show(
  context,
  progressIndicator: LoadingAnimationWidget.threeArchedCircle(
    color: AppColors.purpleColor,
    size: 40,
  ),
);

void showSnackBar(BuildContext context, String content) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );


Widget buttonLoader(BuildContext context) => LoadingAnimationWidget.threeArchedCircle(
  color: Colors.white,
  size: 20,
);