import 'package:flutter/material.dart';
import '../../theme/color/colors.dart';
import '../../theme/style/theme_style.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final Widget? suffixIcon;
  final double? letterSpacing;
  final double? hintLetterSpacing;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.errorText,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
    this.suffixIcon,
    this.letterSpacing,
    this.hintLetterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      style: TextStyle(
        height: 2,
        fontSize: 14,
        color: Colors.black87,
        letterSpacing: letterSpacing,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        errorText: errorText,
        hintStyle: TextStyle(
          color: AppColors.lowGrey,
          fontSize: 14,
          letterSpacing: hintLetterSpacing,
        ),
        filled: true,
        fillColor: AppColors.backfill,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.redd,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.redd,
          ),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
