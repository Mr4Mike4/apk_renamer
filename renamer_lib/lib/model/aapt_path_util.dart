import 'dart:io';

import 'package:path/path.dart' as p;

class AaptPathUtil {

  static const aaptPath = 'bin';

  static Directory getCurrentDir(){
    final scriptUri = Platform.script;
    final file = File.fromUri(scriptUri);
    return file.parent;
  }

  static String getAaptApp(bool isDebugMode) {
    final String aaptDirPath;
    if (isDebugMode) {
      final String? androidHome = Platform.environment['ANDROID_SDK_ROOT'];
      if ((androidHome ?? '').isEmpty) {
        throw Exception('Missing `ANDROID_SDK_ROOT` environment variable.');
      }
      aaptDirPath = Directory(p.join(androidHome!, 'build-tools'))
          .listSync()
          .last
          .path;
    } else {
      final current = getCurrentDir();
      aaptDirPath = p.join(current.path, aaptPath);
    }
    return aaptDirPath;
  }
}