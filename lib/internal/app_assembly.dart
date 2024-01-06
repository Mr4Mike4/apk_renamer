import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:kiwi/kiwi.dart';
import 'package:logger/logger.dart' as l;
import 'package:parser_apk_info/repository/aapt_util.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:renamer_lib/model/aapt_path_util.dart';

import '../data/model/settings_obj.dart';
import '../data/rename_isolate/rename_isolate.dart';
import '../data/repository/database_config_repository.dart';
import '../data/repository/database_repository.dart';
import '../data/repository/preferences_repository.dart';

class AppAssembly {

  static const _portableFileName = 'portable';
  static const _configDir = 'ApkRenamer';

  static Future<bool> checkPortable(Directory current) {
    final portableFile = File(path.join(current.path, _portableFileName));
    return portableFile.exists();
  }

  static Future<DatabaseRepository> _initDatabase(Directory currentDir) async {
    final isPortable = await checkPortable(currentDir);
    final db = DatabaseRepository();
    if(isPortable){
      await db.init(currentDir);
    } else {
      final dir = await getApplicationSupportDirectory();
      await db.init(dir);
    }
    return db;
  }

  static Future<void> init() async {
    if (kDebugMode) {
      l.Logger.level = l.Level.trace;
    } else {
      l.Logger.level = l.Level.off;
    }

    final container = KiwiContainer();

    final currentDir = AaptPathUtil.getCurrentDir();
    final db = await _initDatabase(currentDir);

    container
      ..registerInstance(db.isar)
      ..registerSingleton((di) => DatabaseConfigRepository(di.resolve()))
      ..registerSingleton((di) => PreferencesRepository(di.resolve()))
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
