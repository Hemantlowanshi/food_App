import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zomato_project/ui/home/widgets/category_list.dart';
import 'package:zomato_project/ui/home/widgets/restaurant_card.dart';
import 'package:zomato_project/ui/home/widgets/special_offer_card.dart';

import '../../theme/color/colors.dart';
import '../../theme/style/theme_style.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = 'Pizza';

  final List<Map<String, String>> categories = [
    {'name': 'Burger', 'emoji': '🍔'},
    {'name': 'Donats', 'emoji': '🍩'},
    {'name': 'Pizza', 'emoji': '🍕'},
    {'name': 'Hot Dog', 'emoji': '🌭'},
    {'name': 'Pasta', 'emoji': '🍝'},
  ];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userName = user?.displayName ?? '';
    final userPhotoUrl = user?.photoURL;
    final fallbackInitial = userName.isNotEmpty ? userName[0].toUpperCase() : 'U';

    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // --------------------------------------------------
            // TOP HEADER
            // --------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Menu Button
                  Container(
                    height: 42,
                    width: 42,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/img/menu.png',
                    ),
                  ),

                  // Deliver To
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Deliver to',
                            style: AppTextStyle.poppinsMedium(
                              textColor: AppColors.grey,
                              textSize: 12,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 16,
                            color: AppColors.grey,
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '387 Merdina',
                        style: AppTextStyle.poppinsMedium(
                          textColor: AppColors.black,
                          textSize: 13,
                        ),
                      ),
                    ],
                  ),

                  // Profile Avatar
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 22.5,
                        backgroundColor: AppColors.zomato,
                        backgroundImage: userPhotoUrl != null ? NetworkImage(userPhotoUrl) : null,
                        child: userPhotoUrl == null
                            ? Text(
                                fallbackInitial,
                                style: AppTextStyle.poppinsBold(
                                  textSize: 20,
                                  textColor: AppColors.white,
                                ),
                              )
                            : null,
                      ),

                      // Notification Dot
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // --------------------------------------------------
            // SCROLLABLE CONTENT
            // --------------------------------------------------
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --------------------------------------------------
                    // GREETING
                    // --------------------------------------------------
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ShaderMask(
                        shaderCallback: (bounds) {
                          return const LinearGradient(
                            colors: [
                              AppColors.gradientStart,
                              AppColors.gradientEnd,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ).createShader(bounds);
                        },
                        child: Text(
                          'Good Afternoon!',
                          style: AppTextStyle.poppinsBold(
                            textSize: 26,
                            textColor: AppColors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // --------------------------------------------------
                    // SEARCH BAR
                    // --------------------------------------------------
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.03),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search dishes, restaurants',
                            hintStyle: TextStyle(
                              color: AppColors.lowGrey,
                              fontSize: 14,
                            ),
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: AppColors.lowGrey,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // --------------------------------------------------
                    // CATEGORIES
                    // --------------------------------------------------
                    CategoryList(
                      categories: categories,
                      selectedCategory: _selectedCategory,
                      onCategorySelected: (categoryName) {
                        setState(() {
                          _selectedCategory = categoryName;
                        });
                      },
                    ),

                    const SizedBox(height: 24),

                    // --------------------------------------------------
                    // SPECIAL OFFERS HEADER
                    // --------------------------------------------------
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Special Offers',
                            style: AppTextStyle.poppinsSemiBold(
                              textColor: AppColors.black,
                              textSize: 18,
                            ),
                          ),
                          Text(
                            'View All',
                            style: AppTextStyle.poppinsSemiBold(
                              textColor: AppColors.redd,
                              textSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // --------------------------------------------------
                    // SPECIAL OFFERS
                    // --------------------------------------------------
                    SizedBox(
                      height: 137,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          SpecialOfferCard(
                            backgroundColor: AppColors.zomato,
                            rating: '4.5',
                            title: 'Burger King',
                            subtitle: '🚚 Free delivery',
                            price: '\$22.00',
                            emoji: '🍔',
                            onBuyNowTap: () {},
                          ),

                          SpecialOfferCard(
                            backgroundColor: AppColors.tealCard,
                            rating: '4.8',
                            title: 'Pizza Hut',
                            subtitle: '🔥 20% Off Combo',
                            price: '\$18.50',
                            emoji: '🍕',
                            onBuyNowTap: () {},
                          ),

                          SpecialOfferCard(
                            backgroundColor: AppColors.yellowCard,
                            rating: '4.9',
                            title: 'Tokyo Sushi',
                            subtitle: '⚡ Fast Delivery',
                            price: '\$29.00',
                            emoji: '🍣',
                            onBuyNowTap: () {},
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // --------------------------------------------------
                    // RESTAURANTS HEADER
                    // --------------------------------------------------
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Restaurants',
                            style: AppTextStyle.poppinsSemiBold(
                              textColor: AppColors.black,
                              textSize: 18,
                            ),
                          ),
                          Text(
                            'View All',
                            style: AppTextStyle.poppinsSemiBold(
                              textColor: AppColors.redd,
                              textSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // --------------------------------------------------
                    // RESTAURANT CARDS
                    // --------------------------------------------------
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          RestaurantCard(
                            imageUrl:
                            'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?q=80&w=600&auto=format&fit=crop',
                            title: 'Seafood maki sushi',
                            rating: '4.5',
                            deliveryCostText: 'Free delivery',
                            deliveryTimeText: '45 mins',
                            onFavoriteTap: () {},
                          ),

                          const SizedBox(height: 20),

                          RestaurantCard(
                            imageUrl:
                            'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=600&auto=format&fit=crop',
                            title: 'Classic veg Burger',
                            rating: '4.5',
                            deliveryCostText: 'Free delivery',
                            deliveryTimeText: '30 mins',
                            onFavoriteTap: () {},
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}