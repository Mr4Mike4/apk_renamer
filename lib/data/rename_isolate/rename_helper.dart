import 'dart:async';

import '../../domain/model/file_info.dart';
import '../../logger.dart';
import '../repository/parser_apk_info.dart';
import '../repository/parser_replace_pattern.dart';
import '../repository/renamer_files.dart';

class RenameHelper {
  final _parserApkInfo = ParserApkInfo();
  final _parserPattern = ParserReplacePattern();

  void aaptInit() {
    _parserApkInfo.aaptInit();
  }

  Future<List<FileInfo>> updateFilesInfo(
      List<FileInfo> listInfo, String pattern) async {
    logger.d('UpdateFilesInfoEvent pattern >> $pattern');
    if (listInfo.isNotEmpty) {
      final patternInfo = await _parserPattern.parsePattern(pattern);
      final renamer = RenamerFiles(
        pattern: pattern,
        patternInfo: patternInfo,
      );
      for (int i = 0; i < listInfo.length; i++) {
        final info = listInfo[i];
        final apkInfo = await _parserApkInfo.parseFile(info.file);
        final newFileName = await renamer.createNewName(apkInfo);
        listInfo[i] = info.copyWith(
          newFileName: newFileName,
        );
      }
    }
    return listInfo;
  }
}
