import 'package:flutter/material.dart';
import '../../../theme/color/colors.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 65,
      decoration: BoxDecoration(
        color: AppColors.bottomNavBackground,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              Icons.home_rounded,
              color: selectedIndex == 0 ? AppColors.zomato : AppColors.lowWhite,
              size: 28,
            ),
            onPressed: () => onItemSelected(0),
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_bag_outlined,
              color: selectedIndex == 1 ? AppColors.zomato : AppColors.lowWhite,
              size: 28,
            ),
            onPressed: () => onItemSelected(1),
          ),
          IconButton(
            icon: Icon(
              Icons.notifications_none_rounded,
              color: selectedIndex == 2 ? AppColors.zomato : AppColors.lowWhite,
              size: 28,
            ),
            onPressed: () => onItemSelected(2),
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(
                  Icons.person_outline_rounded,

                  color: selectedIndex == 3
                      ? AppColors.zomato
                      : AppColors.lowWhite,
                  size: 28,
                ),
                onPressed: () => onItemSelected(3),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
