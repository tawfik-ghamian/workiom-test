import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final SharedPrefs _instance = SharedPrefs._internal();

  factory SharedPrefs() => _instance;

  SharedPrefs._internal();

  static Future<SharedPreferences> _prefs() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> setAccessToken(String token) async {
    final prefs = await _prefs();
    await prefs.setString('token', token);
  }

  Future<String> getAccessToken() async {
    final prefs = await _prefs();
    final token = prefs.getString('token');
    return token ?? "";
  }
}
