import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';

import '../../logger.dart';
import '../model/apk_info.dart';
import '../model/file_info.dart';
import '../repository/parser_apk_info.dart';
import '../repository/parser_replace_pattern.dart';
import '../repository/renamer_files.dart';

class RenameHelper {
  final _parserApkInfo = ParserApkInfo();
  final _parserPattern = ParserReplacePattern();

  List<ApkInfo> _listApkInfo = [];

  void aaptInit() {
    _parserApkInfo.aaptInit();
  }

  Future<List<ApkInfo>> loadApkInfo(Iterable<String> paths) async {
    logger.d('loadApkInfo paths >> ${paths.length}');
    List<ApkInfo> listInfo = [];
    for (var path in paths) {
      final file = File(path);
      if (await file.exists()) {
        final apkInfo = await _parserApkInfo.parseFile(file);
        if (apkInfo != null) {
          listInfo.add(apkInfo);
          _listApkInfo.add(apkInfo);
        }
      }
    }
    return listInfo;
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
        final apkInfo = _listApkInfo.firstWhereOrNull((e)=> e.uuid == info.uuid);
        final newFileName = await renamer.createNewName(apkInfo);
        listInfo[i] = info.copyWith(
          newFileName: newFileName,
        );
      }
    }
    return listInfo;
  }
}
