import 'package:flutter/material.dart';
import '../theme/color/colors.dart';
import '../theme/style/theme_style.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onTap;
  final double imageWidth;
  final double imageHeight;

  const SocialLoginButton({
    super.key,
    required this.text,
    required this.imagePath,
    required this.onTap,
    this.imageWidth = 28,
    this.imageHeight = 28,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 57,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.black,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
            side: BorderSide(
              color: AppColors.greyRadi,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(imagePath),
              width: imageWidth,
              height: imageHeight,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: AppTextStyle.poppinsMedium(
                textColor: AppColors.black,
                textSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}