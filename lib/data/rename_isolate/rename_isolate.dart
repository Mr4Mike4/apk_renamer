import 'dart:async';
import 'dart:isolate';

import 'package:apk_renamer/data/rename_isolate/rename_helper.dart';

import '../model/apk_info.dart';
import '../model/file_info.dart';
import 'isolate_msg_obj.dart';

FutureOr<void> _createIsolate(_IsolateInit info) async {
  final receivePort = ReceivePort();

  final renameHelper = RenameHelper();

  info.sendPort.send(IsolateReturn(
    sendPort: receivePort.sendPort,
  ));

  renameHelper.aaptInit();

  receivePort.listen(
    (data) {
      final msg = data as IsolateMsgObj;
      switch (msg) {
        case UpdateFilesInfo():
          renameHelper
              .updateFilesInfo(msg.listInfo, msg.pattern)
              .then((list) => msg.sendReturnPort.send(list));
          break;
        case LoadApkInfo():
          renameHelper
              .loadApkInfo(msg.paths)
              .then((list) => msg.sendReturnPort.send(list));
          break;
      }
    },
    cancelOnError: false,
  );
}

class _IsolateInit {
  const _IsolateInit({
    required this.sendPort,
  });

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

  Future<void> init() async {
    if (hasIsolate) return;
    final receivePort = ReceivePort();
    _renameIsolate = await Isolate.spawn<_IsolateInit>(
      _createIsolate,
      _IsolateInit(
        sendPort: receivePort.sendPort,
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

  Future<List<FileInfo>?> createNewName(
    String pattern,
    List<FileInfo> listInfo,
  ) async {
    final port = ReceivePort();
    _sendPort?.send(UpdateFilesInfo(
      sendReturnPort: port.sendPort,
      pattern: pattern,
      listInfo: listInfo,
    ));
    final obj = await port.first;
    if (obj is List<FileInfo>?) {
      return obj;
    } else {
      return null;
    }
  }
}
