import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class AuthService {
  AuthService._();

  // Session keys
  static const _keyEmail     = 'logged_email';
  static const _keyName      = 'logged_name';
  static const _keyLoginTime = 'login_time';
  static const _sessionDays  = 10;

  // Registered user keys
  static const _keyRegEmail    = 'reg_email';
  static const _keyRegName     = 'reg_name';
  static const _keyRegPassword = 'reg_password';

  static Future<Map<String, String>> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final prefs = await SharedPreferences.getInstance();
    final storedEmail    = prefs.getString(_keyRegEmail);
    final storedPassword = prefs.getString(_keyRegPassword);
    final storedName     = prefs.getString(_keyRegName);

    if (storedEmail == null || storedPassword == null) {
      throw ApiException('No account found. Please sign up first.');
    }

    if (email.trim().toLowerCase() != storedEmail.toLowerCase() ||
        password != storedPassword) {
      throw ApiException('Incorrect email or password.');
    }

    await prefs.setString(_keyEmail, storedEmail);
    await prefs.setString(_keyName, storedName ?? email.split('@').first);
    await prefs.setString(_keyLoginTime, DateTime.now().toIso8601String());

    return {'email': storedEmail, 'name': storedName ?? ''};
  }

  static Future<String> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final prefs = await SharedPreferences.getInstance();

    final existing = prefs.getString(_keyRegEmail);
    if (existing != null &&
        existing.toLowerCase() == email.trim().toLowerCase()) {
      throw ApiException('An account with this email already exists.');
    }

    await prefs.setString(_keyRegEmail, email.trim().toLowerCase());
    await prefs.setString(_keyRegName, name.trim());
    await prefs.setString(_keyRegPassword, password);

    return 'Account created! Please sign in.';
  }

  static Future<Map<String, String>?> getStoredSession() async {
    final prefs = await SharedPreferences.getInstance();
    final email        = prefs.getString(_keyEmail);
    final name         = prefs.getString(_keyName);
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
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyName);
    await prefs.remove(_keyLoginTime);
  }
}
