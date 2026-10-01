import 'package:flutter/material.dart';
import '../theme/color/colors.dart';
import '../theme/style/theme_style.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 270,
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.redd,
            foregroundColor: AppColors.white,
            elevation: 4,
            shadowColor: AppColors.redd.withValues(alpha: 0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36),
            ),
          ),
          child: Text(
            text,
            style: AppTextStyle.poppinsSemiBold(
              textSize: 14,
              textColor: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
