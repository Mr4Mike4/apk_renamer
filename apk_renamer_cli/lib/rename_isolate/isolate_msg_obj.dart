import 'dart:isolate';

import 'package:apk_renamer_cli/model/settings_obj.dart';
import 'package:renamer_lib/model/file_info.dart';

sealed class IsolateMsgObj {
  IsolateMsgObj({required this.sendReturnPort});

  final SendPort sendReturnPort;
}

class UpdateFilesInfo extends IsolateMsgObj {

  UpdateFilesInfo({
    required super.sendReturnPort,
    required this.pattern,
    required this.listInfo,
  });
  final String pattern;
  final List<FileInfo> listInfo;
}

class LoadApkInfo extends IsolateMsgObj {

  LoadApkInfo({
    required super.sendReturnPort,
    required this.paths,
  });
  final Iterable<String> paths;
}

class DeleteFileInfo extends IsolateMsgObj {

  DeleteFileInfo({
    required super.sendReturnPort,
    required this.uuid,
  });
  final String uuid;
}

class RenameFilesInfo extends IsolateMsgObj {

  RenameFilesInfo({
    required super.sendReturnPort,
    required this.listInfo,
    this.destPath,
  });
  final List<FileInfo> listInfo;
  final String? destPath;
}

class SettingsFilesInfo extends IsolateMsgObj {

  SettingsFilesInfo({
    required super.sendReturnPort,
    required this.settings,
  });
  final SettingsObj settings;
}

