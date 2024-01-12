import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:parser_apk_info/parser_apk_info.dart';
import 'package:path/path.dart' as p;

import '../model/file_info.dart';
import '../model/keys.dart';
import 'parser_replace_pattern.dart';
import 'renamer_files.dart';

class RenameController {
  final Logger _logger;
  final ParserApkInfoAapt _parserApkInfo;

  RenameController(this._logger) : _parserApkInfo = ParserApkInfoAapt(_logger);

  final _parserPattern = ParserReplacePattern();

  static const defaultCountSuffix = '_(${Keys2.countSuffix})';

  String? countSuffix;

  final List<ApkInfo> _listApkInfo = [];

  List<ApkInfo> get listApkInfo => List.unmodifiable(_listApkInfo);

  Future<bool> aaptInit(String? aaptPath) {
    return _parserApkInfo.aaptInit(aaptPath);
  }

  Future<List<ApkInfo>> loadApkInfo(Iterable<String> paths) async {
    _logger.d('loadApkInfo paths >> ${paths.length}');
    final List<ApkInfo> listInfo = [];
    for (final path in paths) {
      final file = File(path);
      if (await file.exists()) {
        final apkInfo = await _parserApkInfo.parseFile(file);
        if (apkInfo != null) {
          _listApkInfo.add(apkInfo);
          listInfo.add(apkInfo);
        }
      }
    }
    return listInfo;
  }

  Future<List<FileInfo>> updateFilesInfo(
      List<FileInfo> listInfo, String pattern) async {
    _logger.d('updateFilesInfo pattern >> $pattern');
    final resultList = <FileInfo>[];
    if (listInfo.isNotEmpty && pattern.isNotEmpty) {
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
        resultList.add(info.copyWith(
          newFileName: '$newFileName$ext',
        ));
      }
    }
    return resultList;
  }

  Future<void> deleteFileInfo(String uuid) async {
    _logger.d('deleteFileInfo uuid >> $uuid');
    final info = _listApkInfo.firstWhereOrNull((e) => e.uuid == uuid);
    if (info != null) {
      _listApkInfo.remove(info);
    }
  }

  Future<String> _addFileCount({
    required String destPath,
    required String newFileName,
    required String countSuffix,
  }) async {
    final filePath = p.join(destPath, newFileName);
    final fileName = p.basenameWithoutExtension(filePath);
    final ext = p.extension(filePath);
    var file = File(filePath);
    int count = 1;
    while (await file.exists()) {
      final suffix = countSuffix.replaceAll(Keys2.countSuffix, count.toString());
      count++;
      final name = '$fileName$suffix$ext';
      final path = p.join(destPath, name);
      file = File(path);
    }
    return file.path;
  }

  Future<bool> checkCountSuffix(final String? countSuffix) async {
    _logger.d('checkCountSuffix countSuffix >> $countSuffix');
    if(countSuffix == null) return false;
    return countSuffix.contains(Keys2.countSuffix);
  }

  Future<String> _getCountSuffix() async {
    String? suffix;
    if(await checkCountSuffix(countSuffix)){
      suffix = countSuffix;
    }
    return suffix ?? defaultCountSuffix;
  }

  Future<List<FileInfo>> renameFilesInfo(
    List<FileInfo> listInfo, {
    String? destPath,
  }) async {
    _logger.d('renameFilesInfo listInfo >> ${listInfo.length}');
    final Directory? dest;
    final resultList = <FileInfo>[];
    if (destPath != null) {
      dest = Directory(destPath);
      if (!(await dest.exists())) {
        return resultList;
      }
    }
    final suffix = await _getCountSuffix();
    for (final info in listInfo) {
      final file = info.file;
      final newFileName = info.newFileName;
      if (info.isEnable && newFileName != null && await file.exists()) {
        final File newFile;
        if (destPath != null) {
          final newPath = await _addFileCount(
            destPath: destPath,
            newFileName: newFileName,
            countSuffix: suffix,
          );
          _logger.d('renameFilesInfo copy >> $newPath');
          newFile = await file.copy(newPath);
        } else {
          final newPath = await _addFileCount(
            destPath: file.parent.path,
            newFileName: newFileName,
            countSuffix: suffix,
          );
          _logger.d('renameFilesInfo rename >> $newPath');
          newFile = await file.rename(newPath);
        }
        resultList.add(info.copyWith(
          currentFileName: p.basename(newFile.path),
          file: newFile,
          isEnable: false,
        ));
      } else {
        resultList.add(info.copyWith());
      }
    }
    return resultList;
  }
}
