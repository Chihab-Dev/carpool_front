import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_ON_BOARDING = "PREFS_KEY_ON_BOARDING";
const String PREFS_KEY_ON_ID = "PREFS_KEY_ON_ID";
const String PREFS_KEY_ON_TOKEN = "PREFS_KEY_ON_TOKEN";
const String PREFS_KEY_ON_ROLE = "PREFS_KEY_ON_ROLE";

class AppPrefences {
  final SharedPreferences _sharedPreferences;

  AppPrefences(this._sharedPreferences);

  // onBoarding ::
  Future<void> setWatchedOnBoarding() async {
    await _sharedPreferences.setBool(PREFS_KEY_ON_BOARDING, true);
  }

  bool getWatchedOnBoarding() {
    return _sharedPreferences.getBool(PREFS_KEY_ON_BOARDING) ?? false;
  }

  void removeWatchedOnBoarding() async {
    await _sharedPreferences.remove(PREFS_KEY_ON_BOARDING);
  }

  // is client ::
  Future<void> setRole(String role) async {
    await _sharedPreferences.setString(PREFS_KEY_ON_ROLE, role);
  }

  String getRole() {
    return _sharedPreferences.getString(PREFS_KEY_ON_ROLE) ?? '';
  }

  void removeRole() async {
    await _sharedPreferences.remove(PREFS_KEY_ON_ROLE);
  }

  // id ::
  Future<void> setId(String id) async {
    await _sharedPreferences.setString(PREFS_KEY_ON_ID, id);
  }

  String getId() {
    return _sharedPreferences.getString(PREFS_KEY_ON_ID) ?? '';
  }

  void removeId() async {
    await _sharedPreferences.remove(PREFS_KEY_ON_ID);
  }

  // token ::
  Future<void> setToken(String id) async {
    await _sharedPreferences.setString(PREFS_KEY_ON_TOKEN, id);
  }

  String getToken() {
    return _sharedPreferences.getString(PREFS_KEY_ON_TOKEN) ?? '';
  }

  void removeToken() async {
    await _sharedPreferences.remove(PREFS_KEY_ON_TOKEN);
  }
}
