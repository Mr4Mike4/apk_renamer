import 'dart:async';
import 'dart:isolate';

import 'package:parser_apk_info/model/apk_info.dart';
import 'package:renamer_lib/model/file_info.dart';
import 'package:renamer_lib/repository/rename_controller.dart';

import '../model/settings_obj.dart';
import 'app_logger.dart';
import 'isolate_msg_obj.dart';

FutureOr<void> _createIsolate(_IsolateInit info) async {
  final receivePort = ReceivePort();

  final renameController = RenameController(AppLogger());

  info.sendPort.send(IsolateReturn(
    sendPort: receivePort.sendPort,
  ));

  // final aaptPath = await pref.getAaptPath();
  await renameController.aaptInit(info.settings.aaptPath);
  renameController.countSuffix = info.settings.countSuffix;

  receivePort.listen(
        (data) {
      final msg = data as IsolateMsgObj;
      switch (msg) {
        case UpdateFilesInfo():
          renameController
              .updateFilesInfo(msg.listInfo, msg.template)
              .then((list) => msg.sendReturnPort.send(list));
          break;
        case LoadApkInfo():
          renameController
              .loadApkInfo(msg.paths)
              .then((list) => msg.sendReturnPort.send(list));
          break;
        case DeleteFileInfo():
          renameController
              .deleteFileInfo(msg.uuid);
          break;
        case RenameFilesInfo():
          renameController
              .renameFilesInfo(msg.listInfo, destPath: msg.destPath)
              .then((list) => msg.sendReturnPort.send(list));
          break;
        case SettingsFilesInfo():
          renameController.countSuffix = msg.settings.countSuffix;
          msg.sendReturnPort.send(true);
          break;
      }
    },
    cancelOnError: false,
  );
}

class _IsolateInit {
  const _IsolateInit({
    required this.sendPort,
    required this.settings,
  });

  final SettingsObj settings;
  final SendPort sendPort;
}

class IsolateReturn {
  const IsolateReturn({
    required this.sendPort,
  });

  final SendPort sendPort;
}

class RenameIsolate {
  static const String updateFilesInfo = 'updateFilesInfo';

  Isolate? _renameIsolate;
  SendPort? _sendPort;

  bool get hasIsolate => _renameIsolate != null;

  Future<void> init(SettingsObj settings) async {
    if (hasIsolate) return;
    final receivePort = ReceivePort();
    _renameIsolate = await Isolate.spawn<_IsolateInit>(
      _createIsolate,
      _IsolateInit(
        sendPort: receivePort.sendPort,
        settings: settings,
      ),
      debugName: 'Rename',
    );
    final isolateSyncReturn = await receivePort.first as IsolateReturn;
    _sendPort = isolateSyncReturn.sendPort;
  }

  FutureOr<void> kill() {
    if (hasIsolate) {
      // _receivePort?.close();
      _renameIsolate?.kill(priority: Isolate.immediate);
      _renameIsolate = null;
      // _receivePort = null;
    }
  }

  Future<List<ApkInfo>?> getApkInfo(List<String> paths) async {
    final port = ReceivePort();
    _sendPort?.send(LoadApkInfo(
      sendReturnPort: port.sendPort,
      paths: paths,
    ));
    final obj = await port.first;
    if (obj is List<ApkInfo>?) {
      return obj;
    } else {
      return null;
    }
  }

  Future<List<FileInfo>?> createNewName(String template,
      List<FileInfo> listInfo,) async {
    final port = ReceivePort();
    _sendPort?.send(UpdateFilesInfo(
      sendReturnPort: port.sendPort,
      template: template,
      listInfo: listInfo,
    ));
    final obj = await port.first;
    if (obj is List<FileInfo>?) {
      return obj;
    } else {
      return null;
    }
  }

  Future<void> deleteFileInfo(String uuid) async {
    final port = ReceivePort();
    _sendPort?.send(DeleteFileInfo(
      sendReturnPort: port.sendPort,
      uuid: uuid,
    ));
    // final obj = await port.first;
    // if (obj is List<FileInfo>?) {
    //   return obj;
    // } else {
    //   return null;
    // }
  }

  Future<List<FileInfo>?> renameFilesInfo(List<FileInfo> listInfo, {
    String? destPath,
  }) async {
    final port = ReceivePort();
    _sendPort?.send(RenameFilesInfo(
      sendReturnPort: port.sendPort,
      listInfo: listInfo,
      destPath: destPath,
    ));
    final obj = await port.first;
    if (obj is List<FileInfo>?) {
      return obj;
    } else {
      return null;
    }
  }

  Future<void> updateSettings(SettingsObj settings) async {
    final port = ReceivePort();
    _sendPort?.send(SettingsFilesInfo(
      sendReturnPort: port.sendPort,
      settings: settings,
    ));
    await port.first;
  }
}
