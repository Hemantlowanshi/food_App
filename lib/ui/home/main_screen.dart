import 'package:flutter/material.dart';
import 'package:zomato_project/theme/color/colors.dart';
import 'package:zomato_project/ui/home/home_page.dart';
import 'package:zomato_project/ui/home/home_tabs/cart_page.dart';
import 'package:zomato_project/ui/home/home_tabs/notifications_page.dart';
import 'package:zomato_project/ui/home/home_tabs/profile_page.dart';
import 'package:zomato_project/ui/home/widgets/custom_bottom_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const CartPage(),

    const NotificationsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
