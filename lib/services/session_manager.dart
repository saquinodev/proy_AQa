import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static Future<void> saveSession(String sessionId, String usuario, String tipo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('session_id', sessionId);
    await prefs.setString('usuario', usuario);
    await prefs.setString('tipo', tipo);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('session_id') != null;
  }

  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
