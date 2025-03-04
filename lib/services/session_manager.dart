// Archivo: lib/services/session_manager.dart
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static Future<void> saveSession(int sessionId, String usuario, String tipo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('session_id', sessionId);  // Guardar como int
    await prefs.setString('usuario', usuario);
    await prefs.setString('tipo', tipo);
  }

  static Future<int?> getSessionId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('session_id');  // Recuperar como int
  }

  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('session_id');
  }
}
