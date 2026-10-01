import 'package:flutter/material.dart';
import '../../../theme/color/colors.dart';
import '../../../theme/style/theme_style.dart';


class CategoryList extends StatelessWidget {
  final List<Map<String, String>> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryList({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 112, // Increased height to fit the expanded pill design
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = selectedCategory == cat['name'];

          return GestureDetector(
            onTap: () => onCategorySelected(cat['name']!),
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: isSelected
                  ? Container(
                      width: 75,
                      decoration: BoxDecoration(
                        color: AppColors.mintGreen, // Mint green pill background
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.mintGreen.withValues(alpha: 0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 6),
                          // White circle container for the image/emoji at the top
                          Container(
                            width: 63,
                            height: 63,
                            decoration: const BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                cat['emoji']!,
                                style: const TextStyle(fontSize: 28),
                              ),
                            ),
                          ),
                          const Spacer(),
                          // Label text at the bottom inside the green pill
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(
                              cat['name']!,
                              style: AppTextStyle.poppinsSemiBold(
                                textColor: AppColors.white,
                                textSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      width: 75,
                      child: Column(
                        children: [
                          // Standard white circle container for unselected items
                          Container(
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black.withValues(alpha: 0.04),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                cat['emoji']!,
                                style: const TextStyle(fontSize: 28),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            cat['name']!,
                            style: AppTextStyle.poppinsMedium(
                              textSize: 11,
                              textColor: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
