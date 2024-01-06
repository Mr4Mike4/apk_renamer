import 'package:isar/isar.dart';

import 'database_util.dart';

part 'config_dao.g.dart';

@collection
@Name("Config")
class ConfigDao {
  ConfigDao({
    required this.configKey,
    required this.configValue,
  });
  Id get isarId => DatabaseUtil.fastHash(configKey);

  @Index(unique: true)
  String configKey;

  String? configValue;
}
