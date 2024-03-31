import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_ON_BOARDING = "PREFS_KEY_ON_BOARDING";

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
}
