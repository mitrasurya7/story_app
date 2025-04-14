import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/core/constants/app_string.dart';

class AuthLocalDataSource {
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppString.tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppString.tokenKey);
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppString.tokenKey);
  }
}
