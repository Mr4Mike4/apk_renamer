import 'dart:isolate';

import '../model/file_info.dart';
import '../model/settings_obj.dart';

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
  });
  final List<FileInfo> listInfo;
}

class SettingsFilesInfo extends IsolateMsgObj {

  SettingsFilesInfo({
    required super.sendReturnPort,
    required this.settings,
  });
  final SettingsObj settings;
}

