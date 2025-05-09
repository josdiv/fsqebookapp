import 'package:flutter/material.dart';
import 'package:foursquare_ebbok_app/core/helper/common_loader.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../theme/app_colors.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    required this.text,
    this.backgroundColor = AppColors.orangeColor,
    this.textColor = Colors.white,
    this.onTap,
    this.padding,
    this.height,
    this.borderRadius = 16.0,
    this.fontSize = 16,
    this.loading = false,
    this.opacity = false,
  });

  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final double? height;
  final double borderRadius;
  final double fontSize;
  final bool loading;
  final bool opacity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (loading || !opacity) ? null : onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: height,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: backgroundColor?.withOpacity(opacity ? 1 : 0.4),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        alignment: Alignment.center,
        child: loading ? buttonLoader(context) : Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }
}
