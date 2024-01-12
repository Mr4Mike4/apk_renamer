import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:renamer_lib/model/aapt_path_util.dart';

class PreferencesRepository {

  static const configFileName = 'config.json';

  static Future<Map<String, dynamic>?> getConfig() async {
    // var currentPath = Directory.current.path;
    final current = AaptPathUtil.getCurrentDir();
    final configFile = File(p.join(current.path, configFileName));
    print("config file: ${configFile.path}");
    Map<String, dynamic>? mapConfig;
    if(await configFile.exists()) {
      final js = await configFile.readAsString();
      mapConfig = jsonDecode(js);
    } else {
      await configFile.create();
      final configDefaultMap = {
        // PrefKeys.aaptPath: "",
      };
      final js = jsonEncode(configDefaultMap);
      await configFile.writeAsString(js, flush: true);
    }
    return mapConfig;
  }

}
