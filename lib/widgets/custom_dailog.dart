
import 'package:flutter/material.dart';
import '../theme/color/colors.dart';
import '../theme/style/theme_style.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final String negativeButtonText;
  final String positiveButtonText;
  final Color positiveTextColor;
  final VoidCallback onNegativePressed;
  final VoidCallback onPositivePressed;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.message,
    this.negativeButtonText = 'No',
    this.positiveButtonText = 'Yes',
    this.positiveTextColor = AppColors.redd,
    required this.onNegativePressed,
    required this.onPositivePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
  backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: AppTextStyle.poppinsSemiBold(textSize: 20,textColor: AppColors.black),
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTextStyle.poppinsMedium(
          textColor: AppColors.grey,
          textSize: 14,
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        SizedBox(
          width: 110,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.greyRadi,
              foregroundColor: AppColors.black,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            onPressed: onNegativePressed,
            child: Text(
              negativeButtonText,
              style: AppTextStyle.poppinsMedium(
                textColor: AppColors.black,
                textSize: 14,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 110,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.greyRadi,
              foregroundColor: positiveTextColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            onPressed: onPositivePressed,
            child: Text(
              positiveButtonText,
              style: AppTextStyle.poppinsMedium(
                textColor: positiveTextColor,
                textSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}