import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

import '../../logger.dart';
import '../model/apk_info.dart';

class ParserApkInfo {
  String? _aaptPath;

  final _splitter = const LineSplitter();
  final _regExpPackage = RegExp(r"name='([^']+)' "
      r"versionCode='([^']+)' "
      r"versionName='([^']+)' "
      r"platformBuildVersionName='([^']+)' "
      r"platformBuildVersionCode='([^']+)' "
      r"compileSdkVersion='([^']+)' "
      r"compileSdkVersionCodename='([^']+)'");

  final _regExpValue = RegExp(r"'([^']+)'");

  void aaptInit() {
    final String? androidHome = Platform.environment['ANDROID_SDK_ROOT'];
    if ((androidHome ?? '').isEmpty) {
      throw Exception('Missing `ANDROID_HOME` environment variable.');
    }
    final buildToolsDir = Directory(p.join(androidHome!, 'build-tools'));
    final aaptDir = buildToolsDir.listSync().last.path;
    _aaptPath = p.join(aaptDir, 'aapt2');
  }

  Future<ApkInfo?> parseFile(File file) async {
    final aaptPath = _aaptPath;
    if ((aaptPath ?? '').isEmpty) {
      throw Exception('aapt not found');
    }
    final ProcessResult processResult = await Process.run(
      aaptPath!,
      ['dump', 'badging', file.path],
    );

    final String resultString = processResult.stdout;
    // logger.d('parse >> $resultString');

    final rawDataList = _splitter.convert(resultString);

    String? applicationId;
    String? versionCode;
    String? versionName;
    String? platformBuildVersionName;
    String? platformBuildVersionCode;
    String? compileSdkVersion;
    String? compileSdkVersionCodename;
    String? sdkVersion;
    String? targetSdkVersion;
    String? applicationLabel;

    for (final row in rawDataList) {
      logger.d('row >> $row');
      final arr = row.split(':');
      if (arr.length >= 2) {
        final data = arr[1];
        switch (arr[0]) {
          case 'package':
            final regExpMatch1 = _regExpPackage.firstMatch(data);
            applicationId = regExpMatch1?.group(1);
            versionCode = regExpMatch1?.group(2);
            versionName = regExpMatch1?.group(3);
            platformBuildVersionName = regExpMatch1?.group(4);
            platformBuildVersionCode = regExpMatch1?.group(5);
            compileSdkVersion = regExpMatch1?.group(6);
            compileSdkVersionCodename = regExpMatch1?.group(7);
            break;
          case 'sdkVersion':
            final regExpMatch1 = _regExpValue.firstMatch(data);
            sdkVersion = regExpMatch1?.group(1);
            break;
          case 'targetSdkVersion':
            final regExpMatch1 = _regExpValue.firstMatch(data);
            targetSdkVersion = regExpMatch1?.group(1);
            break;
          case 'application-label':
            final regExpMatch1 = _regExpValue.firstMatch(data);
            applicationLabel = regExpMatch1?.group(1);
            break;
        }
      } else {
        logger.d('error row >> $row');
      }
    }
    return ApkInfo(
      file: file,
      applicationId: applicationId,
      versionCode: versionCode,
      versionName: versionName,
      platformBuildVersionName: platformBuildVersionName,
      platformBuildVersionCode: platformBuildVersionCode,
      compileSdkVersion: compileSdkVersion,
      compileSdkVersionCodename: compileSdkVersionCodename,
      sdkVersion: sdkVersion,
      targetSdkVersion: targetSdkVersion,
      applicationLabel: applicationLabel,
    );
  }

  Future<List<ApkInfo>?> parseFiles(Iterable<File> files) async {
    final list = <ApkInfo>[];
    for (var el in files) {
      final info = await parseFile(el);
      if (info != null) {
        list.add(info);
      }
    }
    return list;
  }
}
