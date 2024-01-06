import 'package:isar/isar.dart';

import '../config/base_config.dart';
import '../database/config_dao.dart';
import '../database/database_util.dart';

class DatabaseConfigRepository extends BaseConfig<ConfigDao>  {
  DatabaseConfigRepository(this._appDatabase);

  final Isar _appDatabase;

  @override
  Future<int> setConfig(ConfigDao value) {
    return _appDatabase.writeTxn(() => _appDatabase.configDaos.put(value));
  }

  @override
  Future<ConfigDao?> getConfig(String key) {
    final id = DatabaseUtil.fastHash(key);
    return _appDatabase.configDaos.get(id);
  }

  @override
  Future<String?> getConfigStr(String key) async {
    final config = await getConfig(key);
    return config?.configValue;
  }

  @override
  Future<ConfigDao?> saveConfig(String key, String? value) async {
    final config = ConfigDao(
      configKey: key,
      configValue: value,
    );
    await setConfig(config);
    return null;
  }
}
