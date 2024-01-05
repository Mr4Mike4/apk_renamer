import 'package:flutter/foundation.dart';
import 'package:kiwi/kiwi.dart';
import 'package:logger/logger.dart' as l;
import 'package:parser_apk_info/repository/aapt_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:renamer_lib/model/aapt_path_util.dart';

import '../data/model/settings_obj.dart';
import '../data/rename_isolate/rename_isolate.dart';
import '../data/repository/database_repository.dart';
import '../data/repository/preferences_repository.dart';

class AppAssembly {
  static Future<void> init() async {
    if (kDebugMode) {
      l.Logger.level = l.Level.trace;
    } else {
      l.Logger.level = l.Level.off;
    }
    PreferencesRepository.init();

    final container = KiwiContainer();

    final dir = await getApplicationDocumentsDirectory();
    final db = DatabaseRepository();
    await db.init(dir);

    container
      ..registerSingleton((di) => PreferencesRepository())
      ..registerInstance(db.isar)
      ..registerSingleton((di) => RenameIsolate());

    final renameIsolate = container.resolve<RenameIsolate>();
    final aaptDirPath = AaptPathUtil.getAaptApp(kDebugMode);
    final aaptPath = await AaptUtil.getAaptApp(aaptDirPath);
    if (aaptPath != null) {
      await renameIsolate.init(SettingsObj(
        aaptPath: aaptPath,
      ));
    }
  }
}
