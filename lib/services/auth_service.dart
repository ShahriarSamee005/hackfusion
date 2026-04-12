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
    final user = await ApiService.login(email: email, password: password);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, user['email'] ?? email);
    await prefs.setString(_keyName, user['name'] ?? '');
    await prefs.setString(_keyLoginTime, DateTime.now().toIso8601String());

    return {
      'email': user['email'] ?? email,
      'name': user['name'] ?? '',
    };
  }

  static Future<String> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    return await ApiService.register(
        name: name, email: email, password: password);
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