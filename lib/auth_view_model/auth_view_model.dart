import 'package:firebase_auth/firebase_auth.dart';
import '../auth_session/auth_sessions.dart';
import '../repository/auth_repository.dart';

class AuthViewModel {
  final AuthRepository _authRepository = AuthRepository();
  final AuthSession _authSession = AuthSession();

  final RegExp _emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');

  final RegExp _passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

  final RegExp _nameRegex = RegExp(r'^[a-zA-Z ]+$');

  // Google Sign-In
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final userCredential = await _authRepository.signInWithGoogle();

      if (userCredential != null && userCredential.user != null) {
        final user = userCredential.user!;
        final token = await user.getIdToken();

        await _authSession.saveSession(
          userName: user.displayName ?? 'User',
          userEmail: user.email ?? '',
          accessToken: token ?? '',
        );
      }

      return userCredential;
    } catch (e) {
      print('Google Sign-In Error: $e');
      return null;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _authRepository.signOut();
      await _authSession.clearSession();
    } catch (e) {
      print('Logout Error: $e');
    }
  }

  String? validateName(String name) {
    name = name.trim();

    if (name.isEmpty) {
      return 'Please enter your name';
    }

    if (name.length < 2) {
      return 'Name must contain at least 2 characters';
    }

    if (!_nameRegex.hasMatch(name)) {
      return 'Please enter a valid name';
    }

    return null;
  }

  String? validateEmail(String email) {
    email = email.trim();

    if (email.isEmpty) {
      return 'Please enter your email';
    }

    if (!_emailRegex.hasMatch(email)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Please enter your password';
    }

    if (!_passwordRegex.hasMatch(password)) {
      return 'Password must contain 8+ characters, uppercase, lowercase, number and special character';
    }

    return null;
  }

  bool validateLogin({
    required String email,
    required String password,
  }) {
    final emailError = validateEmail(email);
    final passwordError = validatePassword(password);

    return emailError == null && passwordError == null;
  }

  bool validateSignUp({
    required String name,
    required String email,
    required String password,
  }) {
    final nameError = validateName(name);
    final emailError = validateEmail(email);
    final passwordError = validatePassword(password);

    return nameError == null &&
        emailError == null &&
        passwordError == null;
  }
}