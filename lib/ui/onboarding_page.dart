import 'package:flutter/material.dart';
import '../../theme/color/colors.dart';
import '../../theme/style/theme_style.dart';
import 'auth/login_page.dart';
import 'auth/sign_up.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.coral,
          child: Stack(
            children: [
              // Background curves
              Positioned.fill(
                child: CustomPaint(
                  painter: ComidaBackgroundPainter(),
                ),
              ),

              // Pizza
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                  'assets/img/pizza.png',
                  width: 390,
                  height: 470,
                  fit: BoxFit.cover,
                ),
              ),

              // Text + Buttons
              Positioned(
                left: 25,
                right: 25,
                bottom: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "I don't feel like\n"
                          "cooking. Let's\n"
                          "order food\n"
                          "delivery.",
                      style: AppTextStyle.poppins(
                        textSize: 33,
                        textColor: AppColors.black,
                      ),
                    ),

                    const SizedBox(height: 52),

                    Row(
                      children: [
                        // Sign Up
                        Expanded(
                          child: SizedBox(
                            height: 54,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SignUpScreen(),
                                  ),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor:
                                AppColors.white.withValues(alpha: 0.2),
                                side: const BorderSide(
                                  color: AppColors.white,
                                  width: 1.2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Log in
                        Expanded(
                          child: SizedBox(
                            height: 54,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.darkButton,
                                foregroundColor: AppColors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'Log in',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Bottom indicator
              Positioned(
                bottom: 7,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 134,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ComidaBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.black.withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    // Top rounded curves
    final Path topCurve1 = Path()
      ..moveTo(-40, size.height * 0.10)
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.30,
        size.width + 40,
        size.height * 0.10,
      );

    final Path topCurve2 = Path()
      ..moveTo(-40, size.height * 0.18)
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.38,
        size.width + 40,
        size.height * 0.18,
      );

    final Path topCurve3 = Path()
      ..moveTo(-40, size.height * 0.26)
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.46,
        size.width + 40,
        size.height * 0.26,
      );

    // Bottom rounded curves
    final Path bottomCurve1 = Path()
      ..moveTo(-40, size.height * 0.72)
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.52,
        size.width + 40,
        size.height * 0.72,
      );

    final Path bottomCurve2 = Path()
      ..moveTo(-40, size.height * 0.80)
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.60,
        size.width + 40,
        size.height * 0.80,
      );

    final Path bottomCurve3 = Path()
      ..moveTo(-40, size.height * 0.88)
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.68,
        size.width + 40,
        size.height * 0.88,
      );

    canvas.drawPath(topCurve1, paint);
    canvas.drawPath(topCurve2, paint);
    canvas.drawPath(topCurve3, paint);

    canvas.drawPath(bottomCurve1, paint);
    canvas.drawPath(bottomCurve2, paint);
    canvas.drawPath(bottomCurve3, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}