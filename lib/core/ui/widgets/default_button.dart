import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    required this.text,
    this.backgroundColor = AppColors.orangeColor,
    this.textColor,
    this.onTap,
    this.padding,
    this.height,
    this.borderRadius = 16.0,
    this.fontSize = 16,
  });

  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final double? height;
  final double borderRadius;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: height,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }
}
