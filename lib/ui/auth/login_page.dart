import 'package:flutter/material.dart';
import 'package:zomato_project/theme/color/colors.dart';

import 'package:zomato_project/ui/auth/sign_up.dart';

import 'package:zomato_project/ui/home/main_screen.dart';

import 'package:zomato_project/widgets/social_login_button.dart';
import 'package:zomato_project/widgets/custom_back_button.dart';
import '../../../auth_view_model/auth_view_model.dart';
import '../../../theme/style/theme_style.dart';
import '../../widgets/custom_text_field.dart';

import '../../widgets/primary_button.dart';
import '../onboarding_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  final AuthViewModel _authViewModel = AuthViewModel();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final emailError = _authViewModel.validateEmail(
      _emailController.text,
    );

    final passwordError = _authViewModel.validatePassword(
      _passwordController.text,
    );

    setState(() {
      _emailError = emailError;
      _passwordError = passwordError;
    });

    if (emailError == null && passwordError == null) {
      debugPrint('Login successful');
    }
  }

  Future<void> _googleLogin() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: AppColors.redd),
      ),
    );

    final result = await _authViewModel.signInWithGoogle();

    if (!mounted) return;
    Navigator.pop(context); // Close the loading dialog

    if (result != null) {
      debugPrint('Google Login Successful');
      debugPrint('Name: ${result.user?.displayName}');
      debugPrint('Email: ${result.user?.email}');
      debugPrint('UID: ${result.user?.uid}');

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
            (Route<dynamic> route) => false,
      );
    } else {
      debugPrint('Google Login Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Stack(
              children: [
                // Background
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: const Color(0xFF161618),
                ),

                // Top Image Section
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          'assets/img/v.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomBackButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WelcomePage(),
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: 36),

                            const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                                letterSpacing: -0.5,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              'Please sign in to your\nexisting account',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.lowGrey,
                              ),
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // White Form Section
                Positioned(
                  top: 225,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36),
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: EdgeInsets.fromLTRB(
                        28,
                        32,
                        28,
                        24 + MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Email Label
                          Text(
                            'Email',
                            style: AppTextStyle.poppinsMedium(
                              textSize: 12,
                              textColor: AppColors.black,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Email Field
                          CustomTextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            hintText: 'example@gmail.com',
                            errorText: _emailError,
                          ),

                          const SizedBox(height: 20),

                          // Password Label
                          Text(
                            'Password',
                            style: AppTextStyle.poppinsMedium(
                              textSize: 12,
                              textColor: AppColors.black,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Password Field
                          CustomTextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            hintText: '* * * * * ',
                            errorText: _passwordError,
                            letterSpacing: 2,
                            hintLetterSpacing: 1.5,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColors.lowGrey,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Forgot Password
                          Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(50, 30),
                                tapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                'Forgot Password',
                                style: AppTextStyle.poppinsMedium(
                                  textColor: AppColors.redd,
                                  textSize: 11,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Login Button
                          PrimaryButton(
                            text: 'Login',
                            onPressed: _login,
                          ),

                          const SizedBox(height: 24),

                          // Or Login With
                          Center(
                            child: Text(
                              'Or login with',
                              style: AppTextStyle.poppinsMedium(
                                textSize: 11,
                                textColor: AppColors.lowGrey,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Social Login Buttons
                          Row(
                            children: [
                              // Facebook
                              Expanded(
                                child: SocialLoginButton(
                                  text: 'Phone',
                                  imagePath: 'assets/img/smartphone.png',
                                  imageWidth: 33,
                                  imageHeight: 33,
                                  onTap: () {
                                  },
                                ),
                              ),

                              const SizedBox(width: 12),

                              // Google
                              Expanded(
                                child: SocialLoginButton(
                                  text: 'GOOGLE',
                                  imagePath: 'assets/img/google.png',
                                  onTap: _googleLogin,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 90),

                          // Sign Up
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don’t have an account? ',
                                  style: AppTextStyle.poppinsMedium(
                                    textColor: AppColors.lowGrey,
                                    textSize: 12,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SignUpScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: AppTextStyle.poppinsMedium(
                                      textColor: AppColors.redd,
                                      textSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}