import '../model/pref_keys.dart';
import 'database_config_repository.dart';

class PreferencesRepository {

  PreferencesRepository(this._databaseConfig);

  final DatabaseConfigRepository _databaseConfig;

  Future<String?> getCountSuffix() {
    return _databaseConfig.getStringOrNull(PrefKeys.countSuffix);
  }

  Future<bool> setCountSuffix(String countSuffix) async {
    final result = await _databaseConfig.setString(PrefKeys.countSuffix, countSuffix);
    return result != null;
  }

  Future<String?> getDestPath() async {
    return _databaseConfig.getStringOrNull(PrefKeys.destPath);
  }

  Future<bool> setDestPath(String destPath) async {
    final result = await _databaseConfig.setString(PrefKeys.destPath, destPath);
    return result != null;
  }

  Future<bool?> getCopyToFolder() async {
    return _databaseConfig.getBool(PrefKeys.copyToFolder, false);
  }

  Future<bool> setCopyToFolder(bool copyToFolder) async {
    final result = await _databaseConfig.setBool(PrefKeys.copyToFolder, copyToFolder);
    return result != null;
  }

  Future<String?> getTemplate() async {
    return _databaseConfig.getStringOrNull(PrefKeys.template);
  }

  Future<bool> setTemplate(String template) async {
    final result = await _databaseConfig.setString(PrefKeys.template, template);
    return result != null;
  }
}
