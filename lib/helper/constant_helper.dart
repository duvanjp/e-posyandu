import 'package:e_posyandu/helper/preferences.dart';

class ConstantHelper {
  static const String PREFS_IS_USER_LOGGED_IN = 'PREFS_IS_USER_LOGGED_IN';
  static const String PREFS_USER_ID = 'PREFS_USER_ID';
  static const String PREFS_USER_NAME = 'PREFS_USER_NAME';
  static const String PREFS_USER_EMAIL = 'PREFS_USER_EMAIL';
  static const String PREFS_USER_ROLE = 'PREFS_USER_ROLE';
  static const String PREFS_USER_USERNAME = 'PREFS_USER_USERNAME';
  static const String PETUGAS = 'petugas';
  static const String PASIEN = 'pasien';

  static Future<bool> isPatient() async {
    final role = await Prefs.getRole;
    if (role == PETUGAS) {
      return false;
    } else {
      return true;
    }
  }
}
