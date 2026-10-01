import 'dart:async';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:zomato_project/theme/color/colors.dart';
import '../../theme/style/theme_style.dart';
import '../auth_session/auth_sessions.dart';
import 'home/main_screen.dart';
import 'onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final AuthSession authSession = AuthSession();
    final isLoggedIn = await authSession.isUserLoggedIn();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const WelcomePage(),
          ),
        );
      }
    });
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _version = 'v${info.version}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.zomato, // Exact coral-orange tone
      body: Stack(
        children: [
          // Background curved accent lines
          Positioned.fill(
            child: CustomPaint(
              painter: ComidaBackgroundPainter(),
            ),
          ),

          // Centered Image & Brand Name
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Delivery Illustration Image
                SizedBox(
                  width: 180,
                  height: 200,
                  child: Image.asset(
                    'assets/img/isolation_Mode.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 10),
                // App Title
                Text(
                  'Comida',
                  style: AppTextStyle.righteous(
                    textSize: 35,
                    textColor: AppColors.white,
                    // White stands out clearly against the zomato red/orange background
                  ),
                ),
              ],
            ),
          ),

          // App Version
          Positioned(
            bottom: 35,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                _version,
                style: AppTextStyle.poppinsMedium(
                  textColor: Colors.white.withValues(alpha: 0.8),
                  textSize: 15,
                ),
              ),
            ),
          ),

          // Bottom home indicator bar
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 130,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Painter for the subtle sweeping background arcs
class ComidaBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    // Top-left curves
    final Path topLeftPath1 = Path()
      ..moveTo(-30, size.height * 0.12)
      ..quadraticBezierTo(size.width * 0.4, size.height * 0.02, size.width + 30, size.height * 0.18);

    final Path topLeftPath2 = Path()
      ..moveTo(-30, size.height * 0.20)
      ..quadraticBezierTo(size.width * 0.4, size.height * 0.10, size.width + 30, size.height * 0.26);

    final Path topLeftPath3 = Path()
      ..moveTo(-30, size.height * 0.28)
      ..quadraticBezierTo(size.width * 0.4, size.height * 0.18, size.width + 30, size.height * 0.34);

    // Bottom-right curves
    final Path bottomRightPath1 = Path()
      ..moveTo(-30, size.height * 0.72)
      ..quadraticBezierTo(size.width * 0.6, size.height * 0.82, size.width + 30, size.height * 0.66);

    final Path bottomRightPath2 = Path()
      ..moveTo(-30, size.height * 0.80)
      ..quadraticBezierTo(size.width * 0.6, size.height * 0.90, size.width + 30, size.height * 0.74);

    final Path bottomRightPath3 = Path()
      ..moveTo(-30, size.height * 0.88)
      ..quadraticBezierTo(size.width * 0.6, size.height * 0.98, size.width + 30, size.height * 0.82);

    canvas.drawPath(topLeftPath1, paint);
    canvas.drawPath(topLeftPath2, paint);
    canvas.drawPath(topLeftPath3, paint);
    canvas.drawPath(bottomRightPath1, paint);
    canvas.drawPath(bottomRightPath2, paint);
    canvas.drawPath(bottomRightPath3, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}