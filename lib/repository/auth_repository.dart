import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_google_sign_in.dart';



class AuthRepository {
  final GoogleAuthService _googleAuthService =
  GoogleAuthService();

  Future<UserCredential?> signInWithGoogle() async {
    return await _googleAuthService.signInWithGoogle();
  }

  Future<void> signOut() async {
    await _googleAuthService.signOut();
  }
}