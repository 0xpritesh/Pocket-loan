// lib/utils/session_manager.dart
import 'package:get_storage/get_storage.dart';

class SessionManager {
  static final _storage = GetStorage();

  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _userIdKey = 'userId';
  static const String _userNameKey = 'userName';
  static const String _userEmailKey = 'userEmail';

  static Future<void> saveSession({
    required String userId,
    required String userName,
    required String userEmail,
  }) async {
    await _storage.write(_isLoggedInKey, true);
    await _storage.write(_userIdKey, userId);
    await _storage.write(_userNameKey, userName);
    await _storage.write(_userEmailKey, userEmail);
  }

  static bool isLoggedIn() => _storage.read(_isLoggedInKey) ?? false;

  static String? getUserId() => _storage.read(_userIdKey);
  static String? getUserName() => _storage.read(_userNameKey);
  static String? getUserEmail() => _storage.read(_userEmailKey);

  static Future<void> clearSession() async {
    await _storage.remove(_isLoggedInKey);
    await _storage.remove(_userIdKey);
    await _storage.remove(_userNameKey);
    await _storage.remove(_userEmailKey);
  }
}