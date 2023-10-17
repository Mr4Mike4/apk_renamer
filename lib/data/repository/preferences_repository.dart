import 'package:shared_preferences/shared_preferences.dart';

import '../model/pref_keys.dart';

class PreferencesRepository {
  final Future<SharedPreferences> _prefsFuture =
      SharedPreferences.getInstance();

  Future<SharedPreferences> get prefsFuture => _prefsFuture;

  static void init() {
    SharedPreferences.setPrefix('apk');
  }

  Future<String?> getAaptPath() async {
    final _prefs = await _prefsFuture;
    return _prefs.getString(PrefKeys.aaptPath);
  }

  Future<bool> setAaptPath(String aaptPath) async {
    final _prefs = await _prefsFuture;
    return _prefs.setString(PrefKeys.aaptPath, aaptPath);
  }

  Future<String?> getDestPath() async {
    final _prefs = await _prefsFuture;
    return _prefs.getString(PrefKeys.destPath);
  }

  Future<bool> setDestPath(String destPath) async {
    final _prefs = await _prefsFuture;
    return _prefs.setString(PrefKeys.destPath, destPath);
  }

  Future<bool?> getCopyToFolder() async {
    final _prefs = await _prefsFuture;
    return _prefs.getBool(PrefKeys.copyToFolder);
  }

  Future<bool> setCopyToFolder(bool copyToFolder) async {
    final _prefs = await _prefsFuture;
    return _prefs.setBool(PrefKeys.copyToFolder, copyToFolder);
  }

  Future<String?> getPattern() async {
    final _prefs = await _prefsFuture;
    return _prefs.getString(PrefKeys.pattern);
  }

  Future<bool> setPattern(String pattern) async {
    final _prefs = await _prefsFuture;
    return _prefs.setString(PrefKeys.pattern, pattern);
  }
}
