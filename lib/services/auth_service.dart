import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class AuthService {
  AuthService._();

  static const _keyEmail     = 'logged_email';
  static const _keyName      = 'logged_name';
  static const _keyLoginTime = 'login_time';
  static const _sessionDays  = 10;

  static Future<Map<String, String>> login({
    required String email,
    required String password,
  }) async {
    // Offline fake auth — any email+password works
    await Future.delayed(const Duration(milliseconds: 800)); // feels real
    final prefs = await SharedPreferences.getInstance();
    final name = email.split('@').first; // derive name from email
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyName, name);
    await prefs.setString(_keyLoginTime, DateTime.now().toIso8601String());
    return {'email': email, 'name': name};
  }

  static Future<String> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return 'Account created! Please sign in.';
  }

  static Future<Map<String, String>?> getStoredSession() async {
    final prefs = await SharedPreferences.getInstance();
    final email      = prefs.getString(_keyEmail);
    final name       = prefs.getString(_keyName);
    final loginTimeStr = prefs.getString(_keyLoginTime);

    if (email == null || loginTimeStr == null) return null;

    final loginTime = DateTime.tryParse(loginTimeStr);
    if (loginTime == null) return null;

    final diff = DateTime.now().difference(loginTime).inDays;
    if (diff >= _sessionDays) {
      await logout();
      return null;
    }

    return {'email': email, 'name': name ?? ''};
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}