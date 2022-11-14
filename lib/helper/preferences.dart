import 'package:e_posyandu/helper/constant_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  static Future<String> getString(String key) async {
    final p = await prefs;
    return p.getString(key) ?? '';
  }

  static Future setString(String key, String value) async {
    final p = await prefs;
    return p.setString(key, value);
  }

  static Future<int> getInt(String key) async {
    final p = await prefs;
    return p.getInt(key) ?? 0;
  }

  static Future setInt(String key, int value) async {
    final p = await prefs;
    return p.setInt(key, value);
  }

  static Future<bool> getBool(String key) async {
    final p = await prefs;
    return p.getBool(key) ?? false;
  }

  static Future setBool(String key, bool value) async {
    final p = await prefs;
    return p.setBool(key, value);
  }

  void clearPreference() async {
    final p = await prefs;
    p.clear();
  }
}

class Prefs {
  static Future setRole(String value) =>
      PreferencesHelper.setString(ConstantHelper.PREFS_USER_ROLE, value);

  static Future<String> get getRole =>
      PreferencesHelper.getString(ConstantHelper.PREFS_USER_ROLE);

  static Future setName(String value) =>
      PreferencesHelper.setString(ConstantHelper.PREFS_USER_NAME, value);

  static Future<String> get getName =>
      PreferencesHelper.getString(ConstantHelper.PREFS_USER_NAME);

  static Future setUserId(String value) =>
      PreferencesHelper.setString(ConstantHelper.PREFS_USER_ID, value);

  static Future<String> get getUserId =>
      PreferencesHelper.getString(ConstantHelper.PREFS_USER_ID);

  static Future setEmail(String value) =>
      PreferencesHelper.setString(ConstantHelper.PREFS_USER_EMAIL, value);

  static Future<String> get getEmail =>
      PreferencesHelper.getString(ConstantHelper.PREFS_USER_EMAIL);

  static Future setLoggedIn(bool value) =>
      PreferencesHelper.setBool(ConstantHelper.PREFS_IS_USER_LOGGED_IN, value);

  static Future<bool> get getLoggedIn =>
      PreferencesHelper.getBool(ConstantHelper.PREFS_IS_USER_LOGGED_IN);

  static Future setUsername(String value) =>
      PreferencesHelper.setString(ConstantHelper.PREFS_USER_USERNAME, value);

  static Future<String> get getUsername =>
      PreferencesHelper.getString(ConstantHelper.PREFS_USER_USERNAME);
}
