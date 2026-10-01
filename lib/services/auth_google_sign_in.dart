import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  bool _initialized = false;

  Future<void> _initialize() async {
    if (_initialized) return;

    await _googleSignIn.initialize(
      serverClientId: '670600149764-csgk0lit7tmop91usortcj0ojk0b2jtb.apps.googleusercontent.com',
    );

    _initialized = true;
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      await _initialize();

      final GoogleSignInAccount googleUser =
      await _googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        throw Exception('Google ID token is null');
      }

      final OAuthCredential credential =
      GoogleAuthProvider.credential(
        idToken: idToken,
      );

      return await _firebaseAuth.signInWithCredential(
        credential,
      );
    } catch (e) {
      print('Google Sign-In Error: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}