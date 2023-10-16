import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;

import '../../logger.dart';
import '../model/apk_info.dart';
import '../model/file_info.dart';
import '../repository/parser_apk_info.dart';
import '../repository/parser_replace_pattern.dart';
import '../repository/renamer_files.dart';

class RenameController {
  final _parserApkInfo = ParserApkInfo();
  final _parserPattern = ParserReplacePattern();

  final List<ApkInfo> _listApkInfo = [];

  Future<bool> aaptInit(String? aaptPath) {
    return _parserApkInfo.aaptInit(aaptPath);
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
    logger.d('updateFilesInfo pattern >> $pattern');
    if (listInfo.isNotEmpty) {
      final patternInfo = await _parserPattern.parsePattern(pattern);
      final renamer = RenamerFiles(
        pattern: pattern,
        patternInfo: patternInfo,
      );
      for (int i = 0; i < listInfo.length; i++) {
        final info = listInfo[i];
        final ext = p.extension(info.file.path);
        final apkInfo =
            _listApkInfo.firstWhereOrNull((e) => e.uuid == info.uuid);
        final newFileName = await renamer.createNewName(apkInfo);
        listInfo[i] = info.copyWith(
          newFileName: '$newFileName$ext',
        );
      }
    }
    return listInfo;
  }

  Future<void> deleteFileInfo(String uuid) async {
    logger.d('deleteFileInfo uuid >> $uuid');
    final info = _listApkInfo.firstWhereOrNull((e) => e.uuid == uuid);
    if (info != null) {
      _listApkInfo.remove(info);
    }
  }

  Future<List<FileInfo>?> renameFilesInfo(List<FileInfo> listInfo) async {
    logger.d('renameFilesInfo listInfo >> ${listInfo.length}');
    for (int i = 0; i < listInfo.length; i++) {
      final info = listInfo[i];
      final file = info.file;
      final newFileName = info.newFileName;
      if (info.isEnable && newFileName != null && await file.exists()) {
        final newPath = p.join(file.parent.path, newFileName);
        logger.d('renameFilesInfo newPath >> $newPath');
        final newFile = await file.rename(newPath);
        listInfo[i] = info.copyWith(
          currentFileName: newFileName,
          file: newFile,
          isEnable: false,
        );
      }
    }
    return listInfo;
  }
}
