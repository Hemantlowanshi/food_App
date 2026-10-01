import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthSession {
  static const String _keyIsLogin = 'is_login';
  static const String _keyUserName = 'user_name';
  static const String _keyUserEmail = 'user_email';

  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';

  final _secureStorage = const FlutterSecureStorage();

  Future<void> saveSession({
    required String userName,
    required String userEmail,
    required String accessToken,
    String? refreshToken,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Save non-sensitive data
    await prefs.setBool(_keyIsLogin, true);
    await prefs.setString(_keyUserName, userName);
    await prefs.setString(_keyUserEmail, userEmail);

    // Save sensitive data
    await _secureStorage.write(key: _keyAccessToken, value: accessToken);
    if (refreshToken != null) {
      await _secureStorage.write(key: _keyRefreshToken, value: refreshToken);
    }
  }

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLogin) ?? false;
  }

  Future<Map<String, String?>> getSessionData() async {
    final prefs = await SharedPreferences.getInstance();

    final userName = prefs.getString(_keyUserName);
    final userEmail = prefs.getString(_keyUserEmail);
    final accessToken = await _secureStorage.read(key: _keyAccessToken);
    final refreshToken = await _secureStorage.read(key: _keyRefreshToken);

    return {
      'user_name': userName,
      'user_email': userEmail,
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.remove(_keyIsLogin);
    await prefs.remove(_keyUserName);
    await prefs.remove(_keyUserEmail);

    await _secureStorage.delete(key: _keyAccessToken);
    await _secureStorage.delete(key: _keyRefreshToken);
  }
}
