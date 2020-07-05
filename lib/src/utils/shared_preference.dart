import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static String types = 'types';
  static String countries = 'countries';
  static String cities = 'cities';
  static String regions = 'regions';

  static String userData = "user-data";

  static Future<bool> saveTokenToSharedPrefs(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString('user-token', token);
  }

  static Future<bool> removeTokenFromSharedPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString('user-token', null);
  }

  static Future<String> loadTokenFromSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('user-token');
  }

  static Future<bool> saveStringToSharedPref(String name, String encode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString('$name-dto', encode);
  }

  static Future<String> loadStringFromSharedPref(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('$name-dto');
  }

  static Future<bool> saveHashToSharedPref(String name, int hash) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setInt('$name-hash', hash);
  }

  static Future<int> loadHashFromSharedPref(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt('$name-hash');
  }

  static Future<bool> saveLangToSharedPref(String lang) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString("langauge", lang);
  }

  static Future<String> loadLangFromSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('langauge');
  }

  static Future<bool> saveDefaultLangToSharedPref(String lang) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString("default-lang", lang);
  }
  static Future<String> loadDefaultLangFromSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('default-lang');
  }
}
