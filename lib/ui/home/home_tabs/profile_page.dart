import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zomato_project/theme/color/colors.dart';
import 'package:zomato_project/ui/onboarding_page.dart';
import '../../../auth_view_model/auth_view_model.dart';
import '../../../theme/style/theme_style.dart';
import '../../../widgets/custom_dailog.dart';
import '../../../widgets/primary_button.dart';
import '../../auth/login_page.dart';

class ProfilePage extends StatelessWidget {
  final AuthViewModel _authViewModel = AuthViewModel();

  ProfilePage({super.key});
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: 'Logout',
          message: 'Are you sure you want to log out?',
          positiveTextColor: Colors.deepOrange,
          onNegativePressed: () {
            Navigator.of(context).pop(); // Close dialog
          },
          onPositivePressed: () async {
            await _authViewModel.logout();
            Navigator.of(context).pop(); // Close dialog
            // logout screen
            if (!context.mounted) return;
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const WelcomePage(),
              ),
                  (route) => false,
            );
          },
        );
      },
    );
  }
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userName = user?.displayName ?? 'Flutter Learner';
    final userEmail = user?.email ?? 'learner@example.com';
    final userPhotoUrl = user?.photoURL;
    final fallbackInitial = userName.isNotEmpty ? userName[0].toUpperCase() : 'U';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: AppTextStyle.poppinsBold(textColor: AppColors.black, textSize: 20),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0.5,
        foregroundColor: AppColors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User Header Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: AppColors.zomato,
                    backgroundImage: userPhotoUrl != null ? NetworkImage(userPhotoUrl) : null,
                    child: userPhotoUrl == null
                        ? Text(
                            fallbackInitial,
                            style: AppTextStyle.poppinsBold(
                              textSize: 28,
                              textColor: AppColors.white,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: AppTextStyle.poppinsSemiBold(textColor: AppColors.black, textSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userEmail,
                          style: AppTextStyle.poppinsMedium(textColor: AppColors.grey, textSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Options Section
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.map, color: AppColors.primary),
                    ),
                    title: Text('Google Map / Location', style: AppTextStyle.poppinsMedium(textColor: AppColors.black, textSize: 13)),
                    subtitle: Text('View saved addresses & map', style: AppTextStyle.poppinsMedium(textColor: AppColors.grey, textSize: 12)),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.grey),
                    onTap: () {
                      // TODO: Navigate to Google Map Screen or handle action
                    },
                  ),
                  const Divider(height: 1, indent: 70, color: AppColors.border),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.orange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.settings, color: AppColors.orange),
                    ),
                    title: Text('Settings', style: AppTextStyle.poppinsMedium(textColor: AppColors.black, textSize: 13)),
                    subtitle: Text('App preferences & security', style: AppTextStyle.poppinsMedium(textColor: AppColors.grey, textSize: 12)),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.grey),
                    onTap: () {
                      // TODO: Navigate to Settings Screen
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Logout Button
            PrimaryButton(
              text: 'Logout',
              onPressed: () async {
                _showLogoutDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
