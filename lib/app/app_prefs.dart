import 'package:flutteradvancedmvvm/core/lang/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
const String PREFS_KEY_LANG = 'PREFS_KEY_LANG';
// ignore: constant_identifier_names
const String PREFS_KEY_ONBOARDING_SCREEN = 'PREFS_KEY_ONBOARDING_SCREEN';
// ignore: constant_identifier_names
const String PREFS_KEY_USER_LOGGED_IN = 'PREFS_KEY_USER_LOGGED_IN';

class AppPrefences {
  final SharedPreferences _sharedPreferences;
  AppPrefences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.ENGLISH.getValue();
    }
  }

  Future<void> setOnBoardingScreenViewed() async{
    _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN, true);
  }

  Future<bool> isOnBoardingScreenViewed() async{
    return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN) ?? false;
  }

  Future<void> setIsUserLoggedIn() async{
    _sharedPreferences.setBool(PREFS_KEY_USER_LOGGED_IN, true);
  }
  Future<bool> isUserLoggedIn() async{
    return _sharedPreferences.getBool(PREFS_KEY_USER_LOGGED_IN) ?? false;
  }
}
